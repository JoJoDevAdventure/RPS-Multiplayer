//
//  AvatarCollectionViewCell.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 08/01/2023.
//

import UIKit

class AvatarCollectionViewCell: UICollectionViewCell {
    
    private lazy var avatarImage = AvatarImageView(frame: .zero)
    
    private lazy var avatarLabel: UILabel = {
       let label = UILabel()
        label.text = L10n.PlayerInfo.SinglePlayer.avatar
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        contentView.addSubview(avatarImage)
        avatarImage.isUserInteractionEnabled = false
        contentView.addSubview(avatarLabel)
    }
    
    private func setupConstraints() {
        let constraints = [
            avatarImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -15),
            
            avatarLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 10),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    public func configure(with avatar: Avatar) {
        avatarImage.image = avatar.image
        avatarLabel.text = avatar.name
        avatarImage.backgroundColor = avatar.mainColor
    }
    
}
