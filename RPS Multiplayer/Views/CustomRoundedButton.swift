//
//  CustomRoundedButton.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 02/01/2023.
//

import UIKit

class CustomRoundedButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        layer.cornerRadius = bounds.height / 2
        layer.borderColor = UIColor(asset: Asset.Colors.label)?.cgColor
        layer.borderWidth = 4
        layer.cornerCurve = .continuous
        setBackgroundColor(UIColor(asset: Asset.Colors.label)!, forState: .highlighted)
        setTitleColor(UIColor(asset: Asset.Colors.background), for: .highlighted)
        clipsToBounds = true
    }

}
