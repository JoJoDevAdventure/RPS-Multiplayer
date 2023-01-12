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
    
    public func goToSinglePlayerScreen(from viewController: UIViewController) {
        let singlePlayer = SinglePlayerInfoViewController()
        viewController.navigationController?.pushViewController(singlePlayer, animated: true)
    }
    
    public func showAvatarsSelection(from viewController: UIViewController) {
        let avatars = AvatarSelectionView()
        avatars.modalPresentationStyle = .popover
        viewController.present(avatars, animated: true)
    }
    
    public func goToPregameScreen(from viewController: UIViewController) {
        let avatars = SinglePlayerPregameViewController()
        avatars.modalPresentationStyle = .fullScreen
        viewController.present(avatars, animated: true)
    }
    
    public func goToSingleGameScreen(from viewController: UIViewController) {
        let vm = SinglePlayerGameViewModel()
        let gameScreen = SinglePlayerGameViewController(viewModel: vm)
        gameScreen.modalPresentationStyle = .fullScreen
        viewController.present(gameScreen, animated: true)
    }
    
    public func goToHomeScreen(from viewController: UIViewController) {
        let vm = HomeViewModel()
        let home = HomeScreen(viewModel: vm)
        home.modalPresentationStyle = .fullScreen
        viewController.present(home, animated: true)
    }
}
