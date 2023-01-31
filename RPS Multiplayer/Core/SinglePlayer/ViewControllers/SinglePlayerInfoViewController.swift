//
//  SinglePlayerInfoViewController.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 08/01/2023.
//

import UIKit
import GoogleMobileAds

class SinglePlayerInfoViewController: UIViewController {
    
    // UI Margins
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
    
    // Avatar
    private var avatar: Avatar = Data.shared.avatars[0]
    // Ads interstitial
    private var interstitial: GADInterstitialAd?
    // local player
    private var player: Player? = nil
    
    private let margins = Margins()
    
    // Avatar label
    private lazy var avatarLabel: UILabel = {
       let label = UILabel()
        label.text = L10n.PlayerInfo.SinglePlayer.avatar
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    // Nickname label
    private lazy var nicknameLabel: UILabel = {
       let label = UILabel()
        label.text = L10n.PlayerInfo.SinglePlayer.nickname
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    // avatar Image
    private lazy var avatarImage = AvatarImageView(avatar: avatar)
    
    // name Textfield
    private lazy var nameTextfield = CustomTextfield(title: L10n.PlayerInfo.SinglePlayer.nicknameExample)
    
    // play button
    private lazy var playButton = PlayButton(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(asset: Asset.Colors.background)
        setupUI()
        setupFunc()
    }
    
    private func setupUI() {
        setupSubviews()
        setupConstraints()
        setupNavBar()
    }
    
    private func setupNavBar() {
        title = L10n.PlayerInfo.SinglePlayer.title
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // add subviews
    private func setupSubviews() {
        view.addSubview(avatarLabel)
        view.addSubview(nicknameLabel)
        view.addSubview(avatarImage)
        avatarImage.delegate = self
        view.addSubview(nameTextfield)
        nameTextfield.delegate = self
        view.addSubview(playButton)
    }
    
    // setup constraints
    private func setupConstraints() {
        let constraints = [
            // avatar label
            avatarLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margins.top * 1.5),
        
            // avatar image
            avatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImage.topAnchor.constraint(equalTo: avatarLabel.bottomAnchor, constant: 10),
            
            // nickname label
            nicknameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margins.left),
            nicknameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: margins.top * 2),
            
            // name textfield
            nameTextfield.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margins.left),
            nameTextfield.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: margins.top),
            nameTextfield.rightAnchor.constraint(equalTo: view.rightAnchor, constant: margins.right),
            nameTextfield.heightAnchor.constraint(equalToConstant: 75),
            
            // play button
            playButton.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor, constant: margins.top * 1.5),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.widthAnchor.constraint(equalTo: nameTextfield.widthAnchor),
            playButton.heightAnchor.constraint(equalTo: nameTextfield.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupFunc() {
        setupGesture()
        setupButtonActions()
        setupObservers()
        getAdRequest()
    }
    
    // add gesture to resign keyboard
    private func setupGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resignKeyboard)))
    }
    
    // resign keyboard
    @objc private func resignKeyboard() {
        nameTextfield.resignFirstResponder()
    }
    
    // add button actions
    private func setupButtonActions() {
        playButton.addAction(UIAction(handler: { _  in
            guard let name = self.nameTextfield.getInputString() else {
                self.nameTextfield.errorAnimation()
                return
            }
            let player = Player(name: name, avatar: self.avatar)
            self.player = player
            self.interstitial?.present(fromRootViewController: self)
        }), for: .touchUpInside)
    }
    
    // add observers
    private func setupObservers() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("didChangeAvatar"), object: nil, queue: nil ) { object in
            guard let avatar = object.object as? Avatar else {
                return
            }
            self.avatar = avatar
            self.avatarImage.image = avatar.image
        }
    }
    
    // init add request
    private func getAdRequest() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-5967220334425968/4976191597",
                                request: request,
                              completionHandler: { [self] ad, error in
                                if let error = error {
                                  print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                  return
                                }
                                interstitial = ad
                                interstitial?.fullScreenContentDelegate = self
                              }
            )
    }
    
}

// MARK: avatar image delegate
extension SinglePlayerInfoViewController: AvatarImageViewDelegate {
    // did tap select avatar
    func didTapSelectAvatar() {
        Coordinator.shared.showAvatarsSelection(from: self)
    }
    
}

// MARK: Textfield delegate
extension SinglePlayerInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextfield.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)

        return newString.count <= maxLength
    }
}

extension SinglePlayerInfoViewController: GADFullScreenContentDelegate {
    
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
        guard let player = player else { return }
        Coordinator.shared.goToPregameScreen(from: self, player: player)
    }

    /// Tells the delegate that the ad will present full screen content.
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Ad will present full screen content.")
    }

    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        guard let player = player else { return }
        Coordinator.shared.goToPregameScreen(from: self, player: player)
    }
    
}
