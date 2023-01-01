//
//  UIView+.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 21/12/2022.
//

import Foundation
import UIKit
import Lottie

extension UIViewController {
    
    // blue loading screeen
    struct LoadingScreen {
        
        // unfocus background
        let unfocusDarkView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .black
            view.alpha = 0.7
            return view
        }()
        
        // loading animation
        let loadingAnimation: LottieAnimationView = {
            let animation = LottieAnimationView()
            animation.animation = LottieAnimation.named("loadingSpinner")
            animation.translatesAutoresizingMaskIntoConstraints = false
            animation.contentMode = .scaleAspectFit
            animation.loopMode = .loop
            return animation
        }()
        
        // show loading screen
        func showLoadingScreen(on view: UIView) {
            /// add views to parent view
            /// pin unfocus view
            /// add & play loading animation
            view.addSubview(unfocusDarkView)
            unfocusDarkView.pinToView(to: view, with: 0)
            view.addSubview(loadingAnimation)
            NSLayoutConstraint.activate([
                loadingAnimation.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
                loadingAnimation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loadingAnimation.heightAnchor.constraint(equalToConstant: 120),
                loadingAnimation.widthAnchor.constraint(equalToConstant: 150),
            ])
            loadingAnimation.play()
        }
        
        // hide loading screen
        func hideLoadingScreen() {
            unfocusDarkView.removeFromSuperview()
            loadingAnimation.removeFromSuperview()
        }
        
    }
    
    // orange loading screen
    struct orangeLoadingScreen {
        
        // unfocus view
        let unfocusDarkView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .black
            view.alpha = 0.7
            return view
        }()
        
        // loading animation
        let loadingAnimation: LottieAnimationView = {
            let animation = LottieAnimationView()
            animation.animation = LottieAnimation.named("orangeLoadingSpinner")
            animation.translatesAutoresizingMaskIntoConstraints = false
            animation.contentMode = .scaleAspectFit
            animation.loopMode = .loop
            return animation
        }()
        
        // show loading screeen
        func showLoadingScreen(on view: UIView) {
            /// add views to parent view
            /// pin unfocus view
            /// add & play loading animation
            view.addSubview(unfocusDarkView)
            unfocusDarkView.pinToView(to: view, with: 0)
            view.addSubview(loadingAnimation)
            NSLayoutConstraint.activate([
                loadingAnimation.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
                loadingAnimation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loadingAnimation.heightAnchor.constraint(equalToConstant: 120),
                loadingAnimation.widthAnchor.constraint(equalToConstant: 150),
            ])
            loadingAnimation.play()
        }
        
        // hide loading screen
        func hideLoadingScreen() {
            unfocusDarkView.removeFromSuperview()
            loadingAnimation.removeFromSuperview()
        }
        
    }
    
}
