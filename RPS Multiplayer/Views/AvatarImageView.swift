//
//  AvatarImageView.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 08/01/2023.
//

import UIKit
protocol AvatarImageViewDelegate: AnyObject {
    func didTapSelectAvatar()
}

class AvatarImageView: UIImageView {
    
    weak var delegate: AvatarImageViewDelegate?

    public var avatar: Avatar
    
    init(avatar: Avatar) {
        self.avatar = avatar
        super.init(frame: .zero)
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        image = avatar.image
        backgroundColor = avatar.mainColor
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: 80).isActive = true
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        layer.cornerRadius = 40
        clipsToBounds = true
    }
    
    private func setupActions() {
        setupGestures()
    }
    
    private func setupGestures() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapSelectAvatar)))
    }
    
    private func setupObservers() {
        
    }
    
    @objc private func didTapSelectAvatar() {
        delegate?.didTapSelectAvatar()
    }
    
}
