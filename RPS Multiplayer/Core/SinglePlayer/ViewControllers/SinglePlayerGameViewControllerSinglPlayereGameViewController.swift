//
//  SingleGameViewController.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 09/01/2023.
//

import UIKit

class SinglePlayerGameViewController: UIViewController {
    
    private lazy var scoreBar = GameScoreView()
    
    private lazy var botHandView = HandView(avatar: Data.shared.avatars[0])
    
    private lazy var playerHandView = HandView(avatar: Data.shared.avatars[0])
    
    private lazy var rockButton = RockButton()
    private lazy var paperButton = PaperButton()
    private lazy var scissorsButton = ScissorsButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupFunc()
    }
    
    private func setupUI() {
        setupSubviews()
        setupConstraints()
        view.backgroundColor = UIColor(asset: Asset.Colors.background)
    }
    
    private func setupSubviews() {
        scoreBar.addViewOn(view)
        
        botHandView.showOnView(view: view, position: .top, withAnimation: true)
        playerHandView.showOnView(view: view, position: .bottom,withAnimation: true)

        view.addSubview(rockButton)
        rockButton.delegate = self
        view.addSubview(paperButton)
        paperButton.delegate = self
        view.addSubview(scissorsButton)
        scissorsButton.delegate = self
    }
    
    private func setupConstraints() {
        let constraints = [
            rockButton.rightAnchor.constraint(equalTo: paperButton.leftAnchor, constant: -30),
            rockButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            paperButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paperButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            scissorsButton.leftAnchor.constraint(equalTo: paperButton.rightAnchor, constant: 30),
            scissorsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupFunc() {
        
    }

}

extension SinglePlayerGameViewController: RockButtonDelegate, PaperButtonDelegate, ScissorsButtonDelegate {
    
    func didSelectRock() {
        botHandView.userDidChose(choice: .scissors)
        playerHandView.userDidChose(choice: .rock)
    }
    
    func didSelectPaper() {
        print("Paper")
        playerHandView.userDidChose(choice: .rock)
    }
    
    func didSelectScissors() {
        print("Scissorrs")
        
    }
    
}
