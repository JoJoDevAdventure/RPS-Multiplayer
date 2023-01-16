//
//  SinglePlayerGameViewControllerViewModel.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 12/01/2023.
//

import Foundation
protocol SinglePlayerGameViewModelOutPut: AnyObject {
    func draw()
    func won(botScore: Int, playerScore: Int)
    func lost(botScore: Int, playerScore: Int)
    func resetGame()
    func replay()
}

class SinglePlayerGameViewModel {
    
    weak var output: SinglePlayerGameViewModelOutPut?
    private var botChoice: RPS?
    private var botScore = 0
    private var playerScore = 0
    
    public func generateBotChoice() -> RPS {
        let choices: [RPS] = [ .scissors, .rock, .paper]
        guard let random = choices.randomElement() else {
            return .paper
        }
        self.botChoice = random
        return random
    }
    
    public func playerDidChose(playerChoice: RPS) {
        if botChoice != nil {
            switch botChoice {
            case .rock:
                switch playerChoice {
                case .rock:
                    output?.draw()
                case .paper:
                    playerScore += 1
                    output?.won(botScore: botScore, playerScore: playerScore)
                case .scissors:
                    botScore += 1
                    output?.lost(botScore: botScore, playerScore: playerScore)
                }
            case .paper:
                switch playerChoice {
                case .rock:
                    botScore += 1
                    output?.lost(botScore: botScore, playerScore: playerScore)
                case .paper:
                    output?.draw()
                case .scissors:
                    playerScore += 1
                    output?.won(botScore: botScore, playerScore: playerScore)
                }
            case .scissors:
                switch playerChoice {
                case .rock:
                    playerScore += 1
                    output?.won(botScore: botScore, playerScore: playerScore)
                case .paper:
                    botScore += 1
                    output?.lost(botScore: botScore, playerScore: playerScore)
                case .scissors:
                    output?.draw()
                }
            case .none:
                break
            }
            
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 3, execute: DispatchWorkItem(block: {
                self.output?.resetGame()
            }))
        }
        
    }
    
    public func replay() {
        self.botScore = 0
        self.playerScore = 0
        output?.replay()
    }
}
