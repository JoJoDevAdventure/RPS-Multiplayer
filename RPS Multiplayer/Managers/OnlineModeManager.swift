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
    func playerConnectToGame(player: MPlayer)
}

final class OnlineModeManager: OnlineGameService {
    
    let db = Firestore.firestore()
    private var localPlayer: MPlayer? = nil
    private var currentGameID: String?
    private var playerID: String = ""
    
    init() {}
    
    internal func connectToGame(completion: Result<Game, MultiplayerErrors>) {
        
    }
    
    internal func playerConnectToGame(player: MPlayer) {
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
                let game = Game(player1: player, player2: nil, isGameReady: false)
                let gameID = try? self.db.collection("games").addDocument(from: game)
                
                // set gameID
                self.currentGameID = gameID?.documentID
                
                // set playerID
                self.playerID = "player1"
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
                    
                    let playerID = try? self.db.collection("games").document(gameid).collection("player2").addDocument(from: player)
                    
                    // mark game as full
                    self.db.collection("games").document(gameid).setData(["isGameReady" : true])
                    self.playerID = "player2"
                }
            }
        
        }
    }
    
    internal func updateGameScore() {
        
    }
    
    internal func endGame() {
        
    }
    
    internal func playerLeft() {
        
    }
    
}
