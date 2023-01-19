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
    
    public func goToPregameScreen(from viewController: UIViewController, player: Player) {
        let avatars = SinglePlayerPregameViewController(player: player)
        avatars.modalPresentationStyle = .fullScreen
        viewController.present(avatars, animated: true)
    }
    
    public func goToSingleGameScreen(from viewController: UIViewController, player: Player) {
        let vm = SinglePlayerGameViewModel()
        let gameScreen = SinglePlayerGameViewController(viewModel: vm, player: player)
        gameScreen.modalPresentationStyle = .fullScreen
        viewController.present(gameScreen, animated: true)
    }
    
    public func goToHomeScreen(from viewController: UIViewController) {
        let vm = HomeViewModel()
        let home = HomeScreen(viewModel: vm)
        let nav = UINavigationController(rootViewController: home)
        nav.modalPresentationStyle = .fullScreen
        viewController.present(nav, animated: true)
    }
    
    public func goToMultiplayerScreen(from viewController: UIViewController) {
        let multi = MultiplayerInfoViewController()
        viewController.navigationController?.pushViewController(multi, animated: true)
    }
    
    public func goToMultiPregameScreen(from viewController: UIViewController, player: Player) {
        let service : OnlineGameService = OnlineModeManager()
        let vm = MultiplayerViewModel(service: service)
        let multi = MultiplayerPregameViewController(player: player, viewModel: vm)
        multi.modalPresentationStyle = .fullScreen
        viewController.present(multi, animated: true)
    }
    
    
    
}
