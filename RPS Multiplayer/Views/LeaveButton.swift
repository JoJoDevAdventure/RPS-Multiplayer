//
//  LeaveButton.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 14/01/2023.
//

import UIKit

class LeaveButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            widthAnchor.constraint(equalToConstant: 40),
            heightAnchor.constraint(equalToConstant: 40),
        ]
        NSLayoutConstraint.activate(constraints)
        layer.cornerRadius = 20
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        setImage(UIImage(systemName: "xmark"), for: .normal)
        setBackgroundColor(.red, forState: .normal)
        setBackgroundColor(.clear, forState: .highlighted)
    }

}
