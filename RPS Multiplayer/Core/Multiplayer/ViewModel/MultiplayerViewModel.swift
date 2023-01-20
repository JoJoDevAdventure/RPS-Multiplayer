//
//  MultiplayerViewModel.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 19/01/2023.
//

import Foundation

protocol MultiplayerPreGameOutput: AnyObject {
    func updateUI(player1: MPlayer?, player2: MPlayer?)
}

protocol MultiplayerGameOutput: AnyObject {
    
}

class MultiplayerViewModel {
    
    let service: OnlineGameService
    weak var preGameoutput: MultiplayerPreGameOutput?
    weak var gameOutput: MultiplayerGameOutput?
    
    var didSkipPregameScreen = false
    
    init(service: OnlineGameService) {
        self.service = service
    }
    
    private func playerToMPlayer(player: Player) -> MPlayer {
        return MPlayer(name: player.name, avatarID: player.avatar.id, score: 0)
    }
    
    public func joinGame(player: Player) {
        service.playerConnectToGame(player: playerToMPlayer(player: player), completion: { result in
            switch result {
            case .success(_):
                self.trackGame()
            case .failure(let error):
                return
            }
        })
    }
    
    public func trackGame() {
        service.connectToGame { [weak self] results in
            switch results {
            case .success(let game):
                if !game.isGameReady {
                    
                } else {
                    if !(self?.didSkipPregameScreen ?? true) {
                        self?.preGameoutput?.updateUI(player1: game.player1, player2: game.player2)
                        self?.didSkipPregameScreen = true
                    } else {
                        
                    }
                    
                }
            case .failure(let failure):
                return
            }
        }
    }
}
