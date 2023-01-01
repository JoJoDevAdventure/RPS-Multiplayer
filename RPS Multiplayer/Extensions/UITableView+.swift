//
//  UITableView.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 21/12/2022.
//

import Foundation
import UIKit

extension UITableView {
    
    // create reuse identifier from cell.type
    public func reuseIdentifier<T>(for type: T.Type) -> String {
        return String(describing: type)
    }
    
    // deque cell with type
    public func dequeResuableCell<T: UITableViewCell>(for type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: reuseIdentifier(for: type), for: indexPath) as? T else {
            fatalError("failed to deque cell.")
        }
        return cell
    }
    
    // register cell with type
    public func registerCell<T: UITableViewCell>(_ type: T.Type) {
        register(type, forCellReuseIdentifier: reuseIdentifier(for: type))
    }
    
}
