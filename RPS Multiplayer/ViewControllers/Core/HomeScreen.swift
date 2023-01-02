//
//  ViewController.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 21/12/2022.
//

import UIKit

class HomeScreen: UIViewController {
    
    // MARK: - UIProperties
    
    private struct Margins {
        
        var top: CGFloat
        var right: CGFloat
        var left: CGFloat
        var bottom: CGFloat
        
        var logoWidth: CGFloat
        var logoHeight: CGFloat
        
        var buttonWidth: CGFloat
        var buttonHeight: CGFloat
        
        init() {
            if UIDevice.current.userInterfaceIdiom == .phone {
                top = 10
                right = -30
                left = 30
                bottom = 20
                
                logoWidth = 250
                logoHeight = 180
                
                buttonWidth = 50
                buttonHeight = 50
            } else {
                top = 20
                right = -30
                left = 30
                bottom = 20
                
                logoWidth = 150
                logoHeight = 80
                
                buttonWidth = 50
                buttonHeight = 50
            }
        }
    }
    
    private let margins = Margins()
    
    private lazy var logo: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(asset: Asset.Images.logo)
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private lazy var settingsButton: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.tintColor = UIColor(asset: Asset.Colors.label)
        let img = UIImage(systemName: "gearshape", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))
        btn.image = img
        btn.action = #selector(didTapSettings)
        return btn
    }()
    
    private lazy var purchaseButton: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.tintColor = UIColor(asset: Asset.Colors.label)
        let img = UIImage(systemName: "cart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))
        btn.image = img
        btn.action = #selector(didTapSettings)
        return btn
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(asset: Asset.Colors.background)
        setupUI()
        setupConstraints()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(logo)
        navigationController?.navigationBar.tintColor = UIColor(asset: Asset.Colors.label)
        navigationItem.rightBarButtonItem = settingsButton
        navigationItem.leftBarButtonItem = purchaseButton
    }
    
    @objc private func didTapSettings() {
        
    }
    
    private func setupConstraints() {
        let constraints = [
            // logo constraints
            logo.widthAnchor.constraint(equalToConstant: margins.logoWidth),
            logo.heightAnchor.constraint(equalToConstant: margins.logoHeight),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margins.top * 2.5),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Func Setup
    
    private func setupFunc() {
        
    }

}

