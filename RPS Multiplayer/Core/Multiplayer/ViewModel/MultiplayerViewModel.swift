//
//  MultiplayerViewModel.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 19/01/2023.
//

import Foundation

class MultiplayerViewModel {
    
    let service: OnlineGameService
    
    init(service: OnlineGameService) {
        self.service = service
    }
    
    private func playerToMPlayer(player: Player) -> MPlayer {
        return MPlayer(name: player.name, avatarID: player.avatar.id, score: 0)
    }
    
    public func joinGame(player: Player) {
        service.playerConnectToGame(player: playerToMPlayer(player: player))
    }
    
}
