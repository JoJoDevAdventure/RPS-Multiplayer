//
//  HomeViewModel.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 03/01/2023.
//

import Foundation
import UIKit
import GoogleMobileAds

protocol HomeViewModelOutput: AnyObject {

}

final class HomeViewModel {
    
    weak var output: HomeViewModelOutput?
    let coordinator = Coordinator.shared

    // Output : User did press settings
    public func didPressSettings(vc: UIViewController) {
        coordinator.goToSettingsScreen(from: vc)
    }
    
    // Output : User did press shop button
    public func didPressShop(vc: UIViewController) {
        coordinator.goToShopScreen(from: vc)
    }
    
    // Ouput : User did press singlePlayer Button
    public func didPressSinglePlayer(vc: UIViewController) {
        coordinator.goToSinglePlayerScreen(from: vc)
    }
    
    // OutPut : User did press multiplayer Button
    public func didPressMultiplayer(vc: UIViewController) {
        coordinator.goToMultiplayerScreen(from: vc)
    }
    
}
