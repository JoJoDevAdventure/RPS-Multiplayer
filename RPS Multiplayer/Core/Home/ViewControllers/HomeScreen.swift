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
                top = 20
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
        let btn = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(didTapSettings))
        btn.tintColor = UIColor(asset: Asset.Colors.label)
        let img = UIImage(systemName: "gearshape", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))
        btn.image = img
        btn.action = #selector(didTapSettings)
        return btn
    }()
    
    private lazy var purchaseButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(didTapPurchase))
        btn.tintColor = UIColor(asset: Asset.Colors.label)
        let img = UIImage(systemName: "cart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        btn.image = img
        btn.action = #selector(didTapPurchase)
        return btn
    }()
    
    private lazy var singlePlayerBtn = CustomRoundedButton(title: L10n.Home.singlePlayer)
    
    private lazy var multiplayerBtn = CustomRoundedButton(title: L10n.Home.multiplayer)
    
    
    // MARK: - ViewModel
    
    private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(asset: Asset.Colors.background)
        setupUI()
        setupFunc()
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
        view.addSubview(singlePlayerBtn)
        view.addSubview(multiplayerBtn)
    }
    
    private func setupConstraints() {
        let constraints = [
            // logo constraints
            logo.widthAnchor.constraint(equalToConstant: margins.logoWidth),
            logo.heightAnchor.constraint(equalToConstant: margins.logoHeight),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margins.top * 2.5),
            
            // single player button
            singlePlayerBtn.widthAnchor.constraint(equalTo: logo.widthAnchor, multiplier: 0.95),
            singlePlayerBtn.heightAnchor.constraint(equalToConstant: 65),
            singlePlayerBtn.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: margins.top*5),
            singlePlayerBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Multiplayer button
            multiplayerBtn.widthAnchor.constraint(equalTo: singlePlayerBtn.widthAnchor),
            multiplayerBtn.heightAnchor.constraint(equalToConstant: 65),
            multiplayerBtn.topAnchor.constraint(equalTo: singlePlayerBtn.bottomAnchor, constant: margins.top*3),
            multiplayerBtn.centerXAnchor.constraint(equalTo: singlePlayerBtn.centerXAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        singlePlayerBtn.layer.cornerRadius = 65/2
        multiplayerBtn.layer.cornerRadius = 65/2
    }
    
    // MARK: - Func
    
    private func setupFunc() {
        setupButtonsActions()
    }
    
    private func setupButtonsActions() {
        singlePlayerBtn.addAction(UIAction(handler: { _ in
            self.viewModel.didPressSinglePlayer(vc: self)
        }), for: .touchUpInside)
        
        multiplayerBtn.addAction(UIAction(handler: { _ in
            // TODO: - implement multiplayer action
        }), for: .touchUpInside)
    }
    
    @objc private func didTapSettings() {
        viewModel.didPressSettings(vc: self)
    }
    
    @objc private func didTapPurchase() {
        viewModel.didPressShop(vc: self)
    }
    
    

}

