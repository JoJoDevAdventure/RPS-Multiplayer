//
//  RockButton.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 10/01/2023.
//

import UIKit

class RockButton: UIButton {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.4
        return view
    }()
    
    private lazy var icon: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .black
        img.alpha = 0.4
        return img
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupFunc()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(backgroundView)
        addSubview(icon)
    }
    
    private func setupConstraints() {
        backgroundView.pinToView(to: self, with: 0)
        icon.pinToView(to: self, with: 20)
    }
    
    private func setupFunc() {
        
    }
    
}
