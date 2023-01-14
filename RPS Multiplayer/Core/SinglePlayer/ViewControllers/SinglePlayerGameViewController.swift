//
//  SingleGameViewController.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 09/01/2023.
//

import UIKit

class SinglePlayerGameViewController: UIViewController {
    
    private lazy var scoreBar = GameScoreView()
    
    private lazy var botHandView = HandView(avatar: Data.shared.avatars[0], position: .top)
    
    private lazy var playerHandView = HandView(avatar: Data.shared.avatars[0], position: .bottom)
    
    private lazy var rockButton = RockButton()
    private lazy var paperButton = PaperButton()
    private lazy var scissorsButton = ScissorsButton()
    
    private lazy var leaveButton = LeaveButton()
    
    let viewModel : SinglePlayerGameViewModel
    
    init(viewModel : SinglePlayerGameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupFunc()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        botHandView.startAnimation()
        playerHandView.startAnimation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        botHandView.stopAnimation()
        playerHandView.stopAnimation()
    }
    
    private func setupUI() {
        setupSubviews()
        setupConstraints()
        view.backgroundColor = UIColor(asset: Asset.Colors.background)
    }
    
    private func setupSubviews() {
        scoreBar.addViewOn(view)
        
        botHandView.showOnView(view: view, withAnimation: true)
        playerHandView.showOnView(view: view,withAnimation: true)

        view.addSubview(rockButton)
        rockButton.delegate = self
        view.addSubview(paperButton)
        paperButton.delegate = self
        view.addSubview(scissorsButton)
        scissorsButton.delegate = self
        
        view.addSubview(leaveButton)
    }
    
    private func didTapLeave() {
        Coordinator.shared.goToHomeScreen(from: self)
    }
    
    private func setupConstraints() {
        let constraints = [
            rockButton.rightAnchor.constraint(equalTo: paperButton.leftAnchor, constant: -30),
            rockButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            paperButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paperButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            scissorsButton.leftAnchor.constraint(equalTo: paperButton.rightAnchor, constant: 30),
            scissorsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            leaveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            leaveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func hideButtons() {
        rockButton.isHidden = true
        paperButton.isHidden = true
        scissorsButton.isHidden = true
    }
    
    private func showButton() {
        rockButton.isHidden = false
        paperButton.isHidden = false
        scissorsButton.isHidden = false
    }
    
    private func setupFunc() {
        setupButtonAction()
    }
    
    private func setupButtonAction() {
        leaveButton.addAction(UIAction(handler: { _ in
            self.didTapLeave()
        }), for: .touchUpInside)
    }

}

extension SinglePlayerGameViewController: RockButtonDelegate, PaperButtonDelegate, ScissorsButtonDelegate {
    
    func didSelectRock() {
        hideButtons()
        let bot = viewModel.generateBotChoice()
        
        playerHandView.userDidChose(choice: .rock)
        botHandView.userDidChose(choice: bot)
        
        viewModel.playerDidChose(playerChoice: .rock)
    }
    
    func didSelectPaper() {
        hideButtons()
        let bot = viewModel.generateBotChoice()
        
        playerHandView.userDidChose(choice: .paper)
        botHandView.userDidChose(choice: bot)
        
        viewModel.playerDidChose(playerChoice: .paper)
    }
    
    func didSelectScissors() {
        hideButtons()
        let bot = viewModel.generateBotChoice()
        
        playerHandView.userDidChose(choice: .scissors)
        botHandView.userDidChose(choice: bot)
        
        viewModel.playerDidChose(playerChoice: .scissors)
    }
    
}

extension SinglePlayerGameViewController: SinglePlayerGameViewModelOutPut {
    
    func draw() {
        // TODO: DRAW animation
    }
    
    func won(botScore: Int, playerScore: Int) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: DispatchWorkItem(block: {
            self.botHandView.losingAnimation()
            self.scoreBar.setScore(player1: botScore, player2: playerScore)
        }))
        
        
    }
    
    func lost(botScore: Int, playerScore: Int) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: DispatchWorkItem(block: {
            self.playerHandView.losingAnimation()
            self.scoreBar.setScore(player1: botScore, player2: playerScore)
        }))
    }
    
    func resetGame() {
        DispatchQueue.main.async {
            self.botHandView.goBackToRest()
            self.playerHandView.goBackToRest()
            self.showButton()
        }
    }
    
    
    
    
}
