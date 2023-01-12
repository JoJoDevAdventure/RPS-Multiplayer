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
    
    var handMovingAnimator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut)

    init(avatar: Avatar) {
        self.avatar = avatar
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
            self.transform = self.transform.translatedBy(x: 0, y: -80)
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
        handMovingAnimator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut) {
            UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1) {
                self.transform = self.transform.translatedBy(x: 0, y: -40)
            } completion: { _ in
                UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1) {
                    self.transform = self.transform.translatedBy(x: 0, y: 40)
                } completion: { _ in
                    self.handMovingAnimation()
                }
            }
        }
        handMovingAnimator.startAnimation()
    }

}

extension HandView {
    
    public func userDidChose(choice: RPS) {
        stopAnimation()
    }
    
    public func goBackToRest() {
        
    }
    
    public func startAnimation() {
        handMovingAnimation()
    }
    
    public func stopAnimation() {
        if handMovingAnimator.isRunning {
            handMovingAnimator.stopAnimation(false)
        }
    }
    
    public func showOnView(view: UIView, position: HandPosition, withAnimation: Bool) {
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
}
