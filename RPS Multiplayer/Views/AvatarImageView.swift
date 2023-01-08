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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        image = UIImage(asset: Asset.Images.Avatars.avatar1)
        backgroundColor = .magenta
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
    
    private func selectedAvatar(Avatar: Avatar) {
        
    }
    
}
