//
//  OnlineModeManager.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 16/01/2023.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

protocol OnlineGameService : AnyObject {
    func playerConnectToGame(player: Player, completion: @escaping (Result<Void, MultiplayerErrors>) -> Void)
    func connectToGame(completion: @escaping (Result<Game, MultiplayerErrors>) -> Void)
    func playerDidChose(choice: RPS ,completion: @escaping (Result<Void, MultiplayerErrors>) -> Void)
}

class OnlineModeManager: OnlineGameService {
    
    let db = Firestore.firestore()
    
    private var localPlayer: MPlayer? = nil
    private var currentGameID: String?
    
    init() {}
    
    private func connectToGame(completion: @escaping (Result<Game, MultiplayerErrors>) -> Void) {
        guard let currentGameID = currentGameID else { return }
        self.db.collection("games").document(currentGameID).addSnapshotListener { snapshot, error in
            guard error == nil else { return }
            guard let snapshot = snapshot else { return }
            guard let game = try? snapshot.data(as: Game.self) else { return }
            
            if self.localPlayer!.playerID == "player1" {
                self.localPlayer = game.player1
            } else {
                self.localPlayer = game.player2
            }
            
            completion(.success(game))
        }
    }
    
    private func playerConnectToGame(player: Player, completion: @escaping (Result<Void, MultiplayerErrors>) -> Void) {
        var MPlayer = MPlayer(name: player.name, avatarID: player.avatar.id, score: 0, choice: nil, playerID: "player1")
        self.localPlayer = MPlayer
        db.collection("games").getDocuments { snapshot, error in
            guard error == nil else {
                return
            }
            // getting all games data
            guard let snapshot = snapshot else { return }
            
            ///* Different cases :
            /// 1- No existing game
            /// 2 - Existing game but full
            /// 3-  Existing game so join
            // no existing game
            guard !snapshot.isEmpty else {
                let game = Game(player1: MPlayer, isGameReady: false)
                let gameID = try? self.db.collection("games").addDocument(from: game).documentID
                
                guard let gameID = gameID else { return }
                
                // set gameID
                self.currentGameID = gameID
                
                completion(.success(()))
                return
            }
            
            // getting all games as objects
            var games: [Game] = []
            snapshot.documents.forEach { document in
                if let game = try? document.data(as: Game.self) {
                    games.append(game)
                }
            }
            
            // navigating through games to find which one is complete
            games.forEach { game in
                // game is full
                if game.isGameReady {
                    return
                }
                
                // game not full
                // insert player as player 2
                else {
                    guard let gameid = game.id else { return }
                    
                    MPlayer.playerID = "player2"
                    self.updateCurrentPlayer(player: MPlayer)
                    
                    let game = Game(player2: MPlayer, isGameReady: true)
                    
                    try? self.db.collection("games").document(gameid).setData(from: game, merge: true)
                    self.currentGameID = gameid
                    completion(.success(()))
                }
            }
            
            if self.currentGameID == nil {
                MPlayer.playerID = "player1"
                self.updateCurrentPlayer(player: MPlayer)
                let game = Game(player1: MPlayer, isGameReady: false)
                let gameID = try? self.db.collection("games").addDocument(from: game).documentID
                
                guard let gameID = gameID else { return }
                // set gameID
                self.currentGameID = gameID
                completion(.success(()))
            }
        
        }
    }
    
    private func playerDidChose(choice: RPS ,completion: @escaping (Result<Void, MultiplayerErrors>) -> Void) {
        
        print(self.currentGameID)
        print(self.localPlayer)
        
        guard let gameID = self.currentGameID else { return }
        guard let player = self.localPlayer else { return }
    
        self.db.collection("games").document(gameID).setData([player.playerID : player], merge: true)
    }
    
    private func updatePlayerScore() {
        
        guard let gameID = self.currentGameID else { return }
        guard let player = self.localPlayer else { return }
        
        self.db.collection("games").document(gameID).setData([player.playerID : ["score" : player.score + 1]], merge: true)
        
    }
    
    private func endGame() {
        guard let gameID = self.currentGameID else { return }
        
        self.db.collection("games").document(gameID).delete()
    }
    
    private func playerLeft() {
        
    }
    
    private func updateCurrentPlayer(player: MPlayer) {
        
    }
    
}
