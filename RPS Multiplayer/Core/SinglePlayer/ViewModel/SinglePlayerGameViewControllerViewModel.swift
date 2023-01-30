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
        // Game logic
        /// Depending on bot choice
        /// Bot did chose   rock : User win if he choses paper and lose if he choses scissors
        /// Bot did chose   paper : User win if he choses scissors and lose if he choses rock
        /// Bot did chose   scissors : User win if he choses rock and lose if he choses paper
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
            // reset game for next round
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 3, execute: DispatchWorkItem(block: {
                self.output?.resetGame()
            }))
        }
        
    }
    
    // User did press relay button : Reinit game
    public func replay() {
        self.botScore = 0
        self.playerScore = 0
        output?.replay()
    }
}
