//
//  HandView.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 09/01/2023.
//

import UIKit
import QuartzCore

public enum HandPosition {
    case top, bottom
}

class HandView: UIImageView {
    
    private var avatar: Avatar
    private var position: HandPosition

    init(avatar: Avatar, position: HandPosition) {
        self.avatar = avatar
        self.position = position
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: 150).isActive = true
        heightAnchor.constraint(equalToConstant: 500).isActive = true
        image = avatar.hand.restImage
    }
    
    private func setupSubviews() {
        
    }
    
    private func setupConstraints() {
        
    }
    
    private func handRevealAnimation(choice: RPS) {
        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1) {
            self.transform = self.transform.translatedBy(x: 0, y: -70)
            switch choice {
            case .rock:
                self.image = self.avatar.hand.rockImage
            case .paper:
                self.image = self.avatar.hand.paperImage
            case .scissors:
                self.image = self.avatar.hand.scissorsImage
            }
        }
    }
    
    private func handMovingAnimation() {
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.autoreverse, .repeat]) {
            self.transform = self.transform.translatedBy(x: 0, y: -40)
        }
    }

}

extension HandView {
    
    public func userDidChose(choice: RPS) {
        stopAnimation()
        handRevealAnimation(choice: choice)
        goBackToRest()
    }
    
    public func goBackToRest() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: DispatchWorkItem(block: {
            self.layer.removeAllAnimations()
            self.stopAnimation()
            self.image = self.avatar.hand.restImage
            self.startAnimation()
        }))
    }
    
    public func startAnimation() {
        handMovingAnimation()
    }
    
    public func stopAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1) { [weak self] in
            self?.transform = CGAffineTransform.identity
            switch self?.position {
            case .top : self?.transform = CGAffineTransform(rotationAngle: 3.2)
            case .bottom : return
            case .none:
                break
            }
        }
        layer.removeAllAnimations()
    }
    
    public func showOnView(view: UIView, withAnimation: Bool) {
        view.addSubview(self)
        var constraints: [NSLayoutConstraint] = []
        switch position {
        case .top:
            transform = CGAffineTransform(rotationAngle: 3.2)
            constraints = [
                centerXAnchor.constraint(equalTo: view.centerXAnchor),
                topAnchor.constraint(equalTo: view.topAnchor, constant: -180)
            ]
        case .bottom:
            constraints = [
                centerXAnchor.constraint(equalTo: view.centerXAnchor),
                bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 180)
            ]
        }
        NSLayoutConstraint.activate(constraints)
        
        if withAnimation {
            startAnimation()
        }
    }
    
    public func hide() {
        self.removeFromSuperview()
    }
    
    public func showLosingAnimation() {
        
        let original = image
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1) { [weak self] in
            self?.tintColor = .red
            self?.image = self?.image?.withTintColor(.red, renderingMode: .alwaysTemplate)
            self?.alpha = 0.7
        } completion: { _ in
            self.image = original
            self.alpha = 1
        }
    }
}
