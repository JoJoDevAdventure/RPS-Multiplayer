//
//  Game.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 18/01/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct Game : Encodable, Decodable{
    @DocumentID var id: String?
    var player1 : MPlayer?
    var player2 : MPlayer?
    var isGameReady : Bool
}

struct MPlayer : Encodable, Decodable {
    var name : String
    var avatarID : Int
    var score : Int
    var choice : RPS?
    var playerID : String
}
