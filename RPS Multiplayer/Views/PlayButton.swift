//
//  PlayButton.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 08/01/2023.
//

import UIKit

class PlayButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        setTitle(L10n.PlayerInfo.SinglePlayer.play, for: .normal)
        
        titleLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
        
        setTitleColor(UIColor(asset: Asset.Colors.background), for: .normal)
        setBackgroundColor(UIColor(asset: Asset.Colors.label)!, forState: .normal)
        
        layer.borderColor = UIColor(asset: Asset.Colors.label)?.cgColor
        layer.borderWidth = 4
        layer.cornerCurve = .continuous
        
        setBackgroundColor(.clear, forState: .highlighted)
        setTitleColor(UIColor(asset: Asset.Colors.label), for: .highlighted)
        
        setTitleShadowColor(UIColor(asset: Asset.Colors.label), for: .highlighted)
        clipsToBounds = true
    }
    
}
