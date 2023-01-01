//
//  NSLayout+.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 21/12/2022.
//

import Foundation
import UIKit

extension UIView {
    
    // Pin view to parent view
    public func pinToView(to: UIView, with margin: CGFloat) {
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: to.leftAnchor, constant: margin),
            self.rightAnchor.constraint(equalTo: to.rightAnchor, constant: -margin),
            self.bottomAnchor.constraint(equalTo: to.bottomAnchor, constant: -margin),
            self.topAnchor.constraint(equalTo: to.topAnchor, constant: margin)
        ])
    }
}

