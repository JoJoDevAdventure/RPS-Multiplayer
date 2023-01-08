//
//  SinglePlayerInfoViewController.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 08/01/2023.
//

import UIKit

class SinglePlayerInfoViewController: UIViewController {
    
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
    
    private lazy var avatarLabel: UILabel = {
       let label = UILabel()
        label.text = L10n.PlayerInfo.SinglePlayer.avatar
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var nicknameLabel: UILabel = {
       let label = UILabel()
        label.text = L10n.PlayerInfo.SinglePlayer.nickname
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var avatarImage = AvatarImageView(frame: .zero)
    
    private lazy var nameTextfield = CustomTextfield(title: L10n.PlayerInfo.SinglePlayer.nicknameExample)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(asset: Asset.Colors.background)
        setupUI()
        avatarImage.delegate = self
    }
    
    private func setupUI() {
        setupSubviews()
        setupConstraints()
        title = L10n.PlayerInfo.SinglePlayer.title
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupSubviews() {
        view.addSubview(avatarLabel)
        view.addSubview(nicknameLabel)
        view.addSubview(avatarImage)
    }
    
    private func setupConstraints() {
        let constraints = [
            avatarLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margins.top * 1.5),
        
            avatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImage.topAnchor.constraint(equalTo: avatarLabel.bottomAnchor, constant: 10),
            
            nicknameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margins.left),
            nicknameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: margins.top * 2),
            
            nameTextfield.leftAnchor.constraint(equalTo: view.leftAnchor),
            nameTextfield.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: margins.top),
            nameTextfield.rightAnchor.constraint(equalTo: view.rightAnchor, constant: margins.right),
            nameTextfield.heightAnchor.constraint(equalToConstant: 75)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    

}

extension SinglePlayerInfoViewController: AvatarImageViewDelegate {
    
    func didTapSelectAvatar() {
        Coordinator.shared.showAvatarsSelection(from: self)
    }
    
}
