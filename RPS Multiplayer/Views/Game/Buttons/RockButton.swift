//
//  RockButton.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 10/01/2023.
//

import UIKit

class RockButton: UIButton {
    
    private lazy var icon: UIImage? = {
        let image = UIImage(asset: Asset.Images.Icons.rockIcon)
        image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 28))
        image?.withTintColor(.white)
        return image
    }()
    
    private lazy var iconPressed: UIImage? = {
        let image = UIImage(asset: Asset.Images.Icons.rockIcon)
        image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 32))
        image?.withTintColor(.white)
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupConstraints()
        
        setBackgroundColor(UIColor(asset: Asset.Colors.darkPurple)!, forState: .normal)
        setBackgroundColor(UIColor(asset: Asset.Colors.lightPurple)!, forState: .highlighted)
        
        setImage(icon, for: .normal)
        setImage(iconPressed, for: .highlighted)
    }
    
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            heightAnchor.constraint(equalToConstant: 80),
            widthAnchor.constraint(equalTo: heightAnchor),
        ]
        layer.cornerRadius = 40
        clipsToBounds = true
        NSLayoutConstraint.activate(constraints)
    }
    
}
