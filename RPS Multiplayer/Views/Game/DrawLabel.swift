//
//  DrawLabel.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 14/01/2023.
//

import UIKit

class DrawLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        text = "DRAW"
        font = .systemFont(ofSize: 48, weight: .bold)
        textColor = UIColor(asset: Asset.Colors.orange)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 1
        layer.shadowOpacity = 1
        textAlignment = .center
        alpha = 0
    }
    
    public func show(on view: UIView) {
        view.addSubview(self)
        
        let constraints = [
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        
        // showing animation
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    public func hide() {
        // Hiding Animation
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { _ in
            self.removeFromSuperview()
        }
    }

}
