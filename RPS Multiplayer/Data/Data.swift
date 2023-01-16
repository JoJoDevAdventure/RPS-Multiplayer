//
//  Data.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 08/01/2023.
//

import Foundation
import UIKit

class Data {
    
    static let shared = Data()
    
    public let avatars: [Avatar] = [
        Avatar(image: UIImage(asset: Asset.Images.Avatars.avatar1), mainColor: .magenta, name: "Joshua", hand: Hand(restImage: UIImage(asset: Asset.Images.Hands.H1.rest)!, rockImage: UIImage(asset: Asset.Images.Hands.H1.rock)!, paperImage: UIImage(asset: Asset.Images.Hands.H1.paper)!, scissorsImage: UIImage(asset: Asset.Images.Hands.H1.scissors)!)),
        Avatar(image: UIImage(asset: Asset.Images.Avatars.avatar2), mainColor: .magenta, name: "Joshua", hand: Hand(restImage: UIImage(asset: Asset.Images.Hands.H1.rest)!, rockImage: UIImage(asset: Asset.Images.Hands.H1.rock)!, paperImage: UIImage(asset: Asset.Images.Hands.H1.paper)!, scissorsImage: UIImage(asset: Asset.Images.Hands.H1.scissors)!)),
        Avatar(image: UIImage(asset: Asset.Images.Avatars.avatar3), mainColor: .magenta, name: "Joshua", hand: Hand(restImage: UIImage(asset: Asset.Images.Hands.H1.rest)!, rockImage: UIImage(asset: Asset.Images.Hands.H1.rock)!, paperImage: UIImage(asset: Asset.Images.Hands.H1.paper)!, scissorsImage: UIImage(asset: Asset.Images.Hands.H1.scissors)!)),
        Avatar(image: UIImage(asset: Asset.Images.Avatars.avatar4), mainColor: .magenta, name: "Joshua", hand: Hand(restImage: UIImage(asset: Asset.Images.Hands.H1.rest)!, rockImage: UIImage(asset: Asset.Images.Hands.H1.rock)!, paperImage: UIImage(asset: Asset.Images.Hands.H1.paper)!, scissorsImage: UIImage(asset: Asset.Images.Hands.H1.scissors)!)),
        Avatar(image: UIImage(asset: Asset.Images.Avatars.avatar5), mainColor: .magenta, name: "Joshua", hand: Hand(restImage: UIImage(asset: Asset.Images.Hands.H1.rest)!, rockImage: UIImage(asset: Asset.Images.Hands.H1.rock)!, paperImage: UIImage(asset: Asset.Images.Hands.H1.paper)!, scissorsImage: UIImage(asset: Asset.Images.Hands.H1.scissors)!)),
        Avatar(image: UIImage(asset: Asset.Images.Avatars.avatar6), mainColor: .magenta, name: "Joshua", hand: Hand(restImage: UIImage(asset: Asset.Images.Hands.H1.rest)!, rockImage: UIImage(asset: Asset.Images.Hands.H1.rock)!, paperImage: UIImage(asset: Asset.Images.Hands.H1.paper)!, scissorsImage: UIImage(asset: Asset.Images.Hands.H1.scissors)!)),
        Avatar(image: UIImage(asset: Asset.Images.Avatars.avatar7), mainColor: .magenta, name: "Joshua", hand: Hand(restImage: UIImage(asset: Asset.Images.Hands.H1.rest)!, rockImage: UIImage(asset: Asset.Images.Hands.H1.rock)!, paperImage: UIImage(asset: Asset.Images.Hands.H1.paper)!, scissorsImage: UIImage(asset: Asset.Images.Hands.H1.scissors)!)),

    ]
    
}
