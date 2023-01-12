//
//  SingleGameViewController.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 09/01/2023.
//

import UIKit

class SinglePlayerGameViewController: UIViewController {
    
    private lazy var scoreBar = GameScoreView()
    
    private lazy var botHandView = HandView()
    
    private lazy var playerHandView = HandView()
    
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
        view.addSubview(rockButton)
    }
    
    private func setupConstraints() {
        let constraints = [
            rockButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rockButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupFunc() {
        
    }

}
