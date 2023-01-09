//
//  UITextfield+.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 21/12/2022.
//

import Foundation

import Foundation
import UIKit

// Padding
extension UITextField {
    
    /// Add padding to the left of placeholder
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    /// Add padding to the right of placeholder
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func errorAnimation() {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.transform = CGAffineTransform(translationX: 0, y: -2)
        } completion: { _ in
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
                self.transform = CGAffineTransform(translationX: 0, y: 4)
            } completion: { _ in
                UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
                    self.transform = CGAffineTransform(translationX: 0, y: -4)
                } completion: { _ in
                    UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
                        self.transform = CGAffineTransform(translationX: 0, y: 4)
                    } completion: { _ in
                        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
                            self.transform = CGAffineTransform(translationX: 0, y: 2)
                        } completion: { _ in
                            
                        }
                    }
                }
            }
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.layer.borderColor = UIColor.red.cgColor
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
                self.layer.borderColor = UIColor.white.cgColor
            }
        }
    }
    
}
