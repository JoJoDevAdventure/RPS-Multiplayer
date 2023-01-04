//
//  Coordinator.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 04/01/2023.
//

import Foundation
import UIKit

final class Coordinator {
    
    static let shared = Coordinator()
    
    public func goToSettingsScreen(from viewController: UIViewController) {
        let settings = SettingsViewController()
        viewController.navigationController?.pushViewController(settings, animated: true)
    }
    
    public func goToShopScreen(from viewController: UIViewController) {
        let shop = ShopViewController()
        viewController.navigationController?.pushViewController(shop, animated: true)
    }
}
