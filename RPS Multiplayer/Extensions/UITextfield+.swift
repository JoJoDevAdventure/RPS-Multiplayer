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
    
}
