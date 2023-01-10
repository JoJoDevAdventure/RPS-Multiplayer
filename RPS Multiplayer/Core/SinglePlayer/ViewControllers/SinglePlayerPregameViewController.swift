//
//  SinglePlayerPregameViewController.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 08/01/2023.
//

import UIKit

class SinglePlayerPregameViewController: UIViewController {
    
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
    
    private lazy var botUsernameLabel: UILabel = {
       let label = UILabel()
        label.text = L10n.PlayerInfo.SinglePlayer.avatar
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var botAvatarImage = AvatarImageView(frame: .zero)
    
    private lazy var VSLabel: UILabel = {
       let label = UILabel()
        label.text = L10n.Pregame.vs
        label.textColor = UIColor(asset: Asset.Colors.orange)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.alpha = 0
        return label
    }()
    
    private lazy var playerUsernameLabel: UILabel = {
       let label = UILabel()
        label.text = L10n.PlayerInfo.SinglePlayer.avatar
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var playerAvatarImage = AvatarImageView(frame: .zero)

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
            botUsernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            botUsernameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:( margins.top * 7) - (UIScreen.main.bounds.height / 1.8)),
            
            botAvatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            botAvatarImage.topAnchor.constraint(equalTo: botUsernameLabel.bottomAnchor, constant: 15 ),
            
            VSLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            VSLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            playerAvatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerAvatarImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: (margins.bottom * -8) +  (UIScreen.main.bounds.height / 1.8)),
            
            playerUsernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerUsernameLabel.bottomAnchor.constraint(equalTo: playerAvatarImage.topAnchor, constant: -15),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
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
    
    private func animationOut() {
        UIView.animate(withDuration: 1.5, delay: 2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseOut) {
            self.botUsernameLabel.transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height / 1.8)
            self.botAvatarImage.transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height / 1.8)
            
            self.playerAvatarImage.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height / 1.8)
            self.playerUsernameLabel.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height / 1.8)
            
            self.VSLabel.alpha = 0
        } completion: { _ in
            Coordinator.shared.goToSingleGameScreen(from: self)
        }
    }
    
}
