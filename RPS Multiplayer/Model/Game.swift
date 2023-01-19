//
//  Game.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 18/01/2023.
//

import Foundation

struct Game {
    var player1 : MPlayer?
    var player2 : MPlayer?
    var isGameReady : Bool
}

struct MPlayer {
    var name : String
    var avatarID : Int
    var score : Int
}
