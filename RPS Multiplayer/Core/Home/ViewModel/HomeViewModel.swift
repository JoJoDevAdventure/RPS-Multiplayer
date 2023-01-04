//
//  HomeViewModel.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 03/01/2023.
//

import Foundation
import UIKit

protocol HomeViewModelOutput: AnyObject {

}

final class HomeViewModel {
    
    weak var output: HomeViewModelOutput?
    let coordinator = Coordinator.shared

    public func didPressSettings(vc: UIViewController) {
        coordinator.goToSettingsScreen(from: vc)
    }
    
    public func didPressShop(vc: UIViewController) {
        coordinator.goToShopScreen(from: vc)
    }
    
}
