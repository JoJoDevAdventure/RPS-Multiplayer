//
//  SinglePlayerPregameViewController.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 08/01/2023.
//

import UIKit

class SinglePlayerPregameViewController: UIViewController {
    
    // margins
    private struct Margins {
        
        var top: CGFloat
        var right: CGFloat
        var left: CGFloat
        var bottom: CGFloat
        
        var logoWidth: CGFloat
        var logoHeight: CGFloat
        
        var buttonWidth: CGFloat
        var buttonHeight: CGFloat
        
        init() {
            if UIDevice.current.userInterfaceIdiom == .phone {
                top = 20
                right = -30
                left = 30
                bottom = 20
                
                logoWidth = 250
                logoHeight = 180
                
                buttonWidth = 50
                buttonHeight = 50
            } else {
                top = 20
                right = -30
                left = 30
                bottom = 20
                
                logoWidth = 150
                logoHeight = 80
                
                buttonWidth = 50
                buttonHeight = 50
            }
        }
    }
    
    private let margins = Margins()
    
    // local player
    private var player: Player
    
    // bot username
    private lazy var botUsernameLabel: UILabel = {
       let label = UILabel()
        label.text = "Bot"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    // bot avatar image
    private lazy var botAvatarImage = AvatarImageView(avatar: Data.shared.avatars[0])
    
    // "VS" Label
    private lazy var VSLabel: UILabel = {
       let label = UILabel()
        label.text = L10n.Pregame.vs
        label.textColor = UIColor(asset: Asset.Colors.orange)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.alpha = 0
        return label
    }()
    
    // Player username
    private lazy var playerUsernameLabel: UILabel = {
       let label = UILabel()
        label.text = L10n.PlayerInfo.SinglePlayer.avatar
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    // Player Avatar image
    private lazy var playerAvatarImage = AvatarImageView(avatar: player.avatar)

    init(player: Player) {
        self.player = player
        super.init(nibName: nil, bundle: nil)
        self.player = player
        playerUsernameLabel.text = player.name
        playerAvatarImage.image = player.avatar.image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animationIn()
    }

    private func setupUI() {
        setupSubviews()
        setupConstraints()
        view.backgroundColor = UIColor(asset: Asset.Colors.background)
    }
    
    private func setupSubviews() {
        view.addSubview(botUsernameLabel)
        view.addSubview(botAvatarImage)
        view.addSubview(VSLabel)
        view.addSubview(playerUsernameLabel)
        view.addSubview(playerAvatarImage)
    }
    
    private func setupConstraints() {
        let constraints = [
            // bot username
            botUsernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            botUsernameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:( margins.top * 7) - (UIScreen.main.bounds.height / 1.8)),
            
            // bot avatar image
            botAvatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            botAvatarImage.topAnchor.constraint(equalTo: botUsernameLabel.bottomAnchor, constant: 15 ),
            
            // "VS" Label
            VSLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            VSLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // Avatar image
            playerAvatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerAvatarImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: (margins.bottom * -8) +  (UIScreen.main.bounds.height / 1.8)),
            
            // player username label
            playerUsernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerUsernameLabel.bottomAnchor.constraint(equalTo: playerAvatarImage.topAnchor, constant: -15),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // animation : IN
    private func animationIn() {
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.botUsernameLabel.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height / 1.8)
            self.botAvatarImage.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height / 1.8)
            
            self.playerAvatarImage.transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height / 1.8)
            self.playerUsernameLabel.transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height / 1.8)
            
            self.VSLabel.alpha = 1
        } completion: { _ in
            self.animationOut()
        }
    }
    
    // animation : OUT
    private func animationOut() {
        UIView.animate(withDuration: 1.5, delay: 2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseOut) {
            self.botUsernameLabel.transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height / 1.8)
            self.botAvatarImage.transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height / 1.8)
            
            self.playerAvatarImage.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height / 1.8)
            self.playerUsernameLabel.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height / 1.8)
            
            self.VSLabel.alpha = 0
        } completion: { _ in
            Coordinator.shared.goToSingleGameScreen(from: self, player: self.player)
        }
    }
    
}
