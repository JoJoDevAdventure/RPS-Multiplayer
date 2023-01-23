//
//  MultiplayerGameViewController.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 13/01/2023.
//

import UIKit

class MultiplayerGameViewController: UIViewController {

    private lazy var scoreBar = GameScoreView(player1: rivalPlayer, player2: player)
    
    private lazy var botHandView = HandView(avatar: Data.shared.avatars[0], position: .top)
    
    private lazy var playerHandView = HandView(avatar: Data.shared.avatars[0], position: .bottom)
    
    private lazy var rockButton = RockButton()
    private lazy var paperButton = PaperButton()
    private lazy var scissorsButton = ScissorsButton()
    
    private lazy var leaveButton = LeaveButton()
    
    private lazy var drawLabel = DrawLabel()
    
    private lazy var winLoseAlert = CustomAlertController()
    
    let viewModel : MultiplayerViewModel
    
    private let player : Player
    private let rivalPlayer : Player
    
    init(viewModel : MultiplayerViewModel, player: Player, rivalPlayer: Player) {
        self.viewModel = viewModel
        self.player = player
        self.rivalPlayer = rivalPlayer
        super.init(nibName: nil, bundle: nil)
        viewModel.gameOutput = self
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
        winLoseAlert.delegate = self
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
    
    internal func hideButtons() {
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

    @objc func didTapLeave() {
        Coordinator.shared.goToHomeScreen(from: self)
    }
}

extension MultiplayerGameViewController: RockButtonDelegate, PaperButtonDelegate, ScissorsButtonDelegate {
    
    func didSelectRock() {
        // TODO: Handle player selection
        viewModel.updatePlayerChoice(choice: .rock, player: self.player)
    }
    
    func didSelectPaper() {
        // TODO: Handle player selection
        viewModel.updatePlayerChoice(choice: .paper, player: self.player)
    }
    
    func didSelectScissors() {
        // TODO: Handle player selection
        viewModel.updatePlayerChoice(choice: .scissors, player: self.player)
    }
    
}

extension MultiplayerGameViewController: MultiplayerGameOutput {
    
    func shouldHideButtons() {
        hideButtons()
    }
    
    func draw() {
        
    }
    
    func won() {
        
    }
    
    func lost() {
        
    }
    
    func resetGame() {
        
    }
    
    func replay() {
        
    }
    
    
}

extension MultiplayerGameViewController: CustomAlertControllerDelegate {
    
    func didTapRetry() {
//        viewModel.replay()
        winLoseAlert.hide()
    }

    func didTapLeaveGame() {
        Coordinator.shared.goToHomeScreen(from: self)
    }
}
