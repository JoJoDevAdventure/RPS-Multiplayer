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
            self.leftAnchor.constraint(equalTo: to.safeAreaLayoutGuide.leftAnchor, constant: margin),
            self.rightAnchor.constraint(equalTo: to.safeAreaLayoutGuide.rightAnchor, constant: -margin),
            self.bottomAnchor.constraint(equalTo: to.safeAreaLayoutGuide.bottomAnchor, constant: -margin),
            self.topAnchor.constraint(equalTo: to.safeAreaLayoutGuide.topAnchor, constant: margin)
        ])
    }
}

