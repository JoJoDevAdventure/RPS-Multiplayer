//
//  OnlineModeManager.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 16/01/2023.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

protocol OnlineGameService {
    func playerConnectToGame(player: MPlayer, completion: @escaping (Result<Void, MultiplayerErrors>) -> Void)
    func connectToGame(completion: @escaping (Result<Game, MultiplayerErrors>) -> Void)
    func playerDidChose(player: MPlayer, completion: @escaping (Result<Void, MultiplayerErrors>) -> Void)
}

final class OnlineModeManager: OnlineGameService {
    
    let db = Firestore.firestore()
    private var localPlayer: MPlayer? = nil
    private var currentGameID: String?
    private var playerID: String?
    
    init() {}
    
    internal func connectToGame(completion: @escaping (Result<Game, MultiplayerErrors>) -> Void) {
        guard let currentGameID = currentGameID else { return }
        self.db.collection("games").document(currentGameID).addSnapshotListener { snapshot, error in
            guard error == nil else { return }
            guard let snapshot = snapshot else { return }
            guard let game = try? snapshot.data(as: Game.self) else { return }
            completion(.success(game))
        }
    }
    
    internal func playerConnectToGame(player: MPlayer, completion: @escaping (Result<Void, MultiplayerErrors>) -> Void) {
        self.localPlayer = player
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
                let game = Game(player1: player, isGameReady: false)
                let gameID = try? self.db.collection("games").addDocument(from: game).documentID
                
                guard let gameID = gameID else { return }
                
                // set gameID
                self.currentGameID = gameID
                self.playerID = "player1"
                
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
                    
                    let game = Game(player2: player, isGameReady: true)
                    try? self.db.collection("games").document(gameid).setData(from: game, merge: true)
                    self.currentGameID = gameid
                    self.playerID = "player2"
                    
                    completion(.success(()))
                }
            }
            
            if self.currentGameID == nil {
                let game = Game(player1: player, isGameReady: false)
                let gameID = try? self.db.collection("games").addDocument(from: game).documentID
                self.playerID = "player1"
                guard let gameID = gameID else { return }
                // set gameID
                self.currentGameID = gameID
                completion(.success(()))
            }
        
        }
    }
    
    internal func playerDidChose(player: MPlayer, completion: @escaping (Result<Void, MultiplayerErrors>) -> Void) {
        if self.playerID == "player1" {
            self.db.collection("games").document(currentGameID!).setData(["player1" : player])
            completion(.success(()))
        } else if self.playerID == "player2" {
            self.db.collection("games").document(currentGameID!).setData(["player2" : player])
            completion(.success(()))
        } else {
            completion(.failure(MultiplayerErrors.RPSFetchingDataError))
        }
    }
    
    internal func updatePlayerScore() {

    }
    
    internal func endGame() {
        
    }
    
    internal func playerLeft() {
        
    }
    
}
