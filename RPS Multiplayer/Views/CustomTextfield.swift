//
//  CustomTextfield.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 08/01/2023.
//

import UIKit

class CustomTextfield: UITextField {

    init(title: String) {
        super.init(frame: .zero)
        attributedPlaceholder = NSAttributedString(
            string: title,
            attributes : [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        setLeftPaddingPoints(15)
    }
    
}
