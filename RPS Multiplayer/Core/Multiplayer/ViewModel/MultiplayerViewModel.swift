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
    func draw()
    func won()
    func lost()
    func resetGame()
    func replay()
}

class MultiplayerViewModel {
    
    let service: OnlineGameService
    weak var preGameoutput: MultiplayerPreGameOutput?
    weak var gameOutput: MultiplayerGameOutput?
    var player: Player?
    var currentScore: Int = 0
    var localChoice: RPS?
    
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
            case .failure(_):
                return
            }
        })
    }
    
    public func trackGame() {
        service.connectToGame { [weak self] results in
            switch results {
            case .success(let game):
                if !game.isGameReady {
                    //TODO: Loadin screen
                } else {
                    // check if player skipped the pregame animation
                    if !(self?.didSkipPregameScreen ?? true) {
                        self?.preGameoutput?.updateUI(player1: game.player1, player2: game.player2)
                        self?.didSkipPregameScreen = true
                    } else {
                        // check if both player didChose
                        guard let p1Choice = game.player1?.choice else { return }
                        guard let p2Choice = game.player2?.choice else { return }
                        
                        // check wich player is player1
                        if game.player1?.name == self?.player?.name {
                            // the current player is player1
                            self?.localChoice = game.player1?.choice
                            self?.playersDidChose(rivalChoice: game.player2!.choice!)
                        } else {
                            // the current player is player2
                            self?.localChoice = game.player2?.choice
                            self?.playersDidChose(rivalChoice: game.player1!.choice!)
                        }
                    }
                    
                }
            case .failure(_):
                return
            }
        }
    }
    
    public func updatePlayerChoice(choice: RPS) {
        guard var player = player else { return }
        let Mplayer = MPlayer(name: player.name, avatarID: player.avatar.id, score: currentScore, choice: choice)
        service.playerDidChose(Player: Mplayer) { results in
            switch results {
            case .success(_):
                // TODO: Handle sucess in case of player choice
                return
            case .failure(_):
                // TODO: Handle errors
                return
            }
        }
    }
    
    private func playersDidChose(rivalChoice: RPS) {

        switch localChoice {
        case .rock:
            switch rivalChoice {
            case .rock:
                gameOutput?.draw()
            case .paper:
                gameOutput?.won()
            case .scissors:
                gameOutput?.lost()
            }
        case .paper:
            switch rivalChoice {
            case .rock:
                gameOutput?.lost()
            case .paper:
                gameOutput?.draw()
            case .scissors:
                gameOutput?.won()
            }
        case .scissors:
            switch rivalChoice {
            case .rock:
                gameOutput?.won()
            case .paper:
                gameOutput?.lost()
            case .scissors:
                gameOutput?.draw()
            }
        case .none:
            break
        }
        
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 3, execute: DispatchWorkItem(block: {
            self.gameOutput?.resetGame()
        }))
        
    }
    
}
