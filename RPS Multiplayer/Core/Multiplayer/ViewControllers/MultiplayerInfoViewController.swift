//
//  MultiplayerInfoViewController.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 13/01/2023.
//

import UIKit
import GoogleMobileAds

class MultiplayerInfoViewController: UIViewController {
    
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
    
    private var avatar: Avatar = Data.shared.avatars[0]
    private var interstitial: GADInterstitialAd?
    private var player: Player? = nil
    
    private let margins = Margins()
    
    
    private lazy var avatarLabel: UILabel = {
       let label = UILabel()
        label.text = L10n.PlayerInfo.SinglePlayer.avatar
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var nicknameLabel: UILabel = {
       let label = UILabel()
        label.text = L10n.PlayerInfo.SinglePlayer.nickname
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    
    private lazy var avatarImage = AvatarImageView(avatar: avatar)
    
    private lazy var nameTextfield = CustomTextfield(title: L10n.PlayerInfo.SinglePlayer.nicknameExample)
    
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
        title = L10n.PlayerInfo.SinglePlayer.title
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupSubviews() {
        view.addSubview(avatarLabel)
        view.addSubview(nicknameLabel)
        view.addSubview(avatarImage)
        avatarImage.delegate = self
        view.addSubview(nameTextfield)
        nameTextfield.delegate = self
        view.addSubview(playButton)
    }
    
    private func setupConstraints() {
        let constraints = [
            avatarLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margins.top * 1.5),
        
            avatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImage.topAnchor.constraint(equalTo: avatarLabel.bottomAnchor, constant: 10),
            
            nicknameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margins.left),
            nicknameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: margins.top * 2),
            
            nameTextfield.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margins.left),
            nameTextfield.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: margins.top),
            nameTextfield.rightAnchor.constraint(equalTo: view.rightAnchor, constant: margins.right),
            nameTextfield.heightAnchor.constraint(equalToConstant: 75),
            
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
    
    private func setupGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resignKeyboard)))
    }
    
    @objc private func resignKeyboard() {
        nameTextfield.resignFirstResponder()
    }
    
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
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("didChangeAvatar"), object: nil, queue: nil ) { object in
            guard let avatar = object.object as? Avatar else {
                return
            }
            self.avatar = avatar
            self.avatarImage.image = avatar.image
        }
    }
    
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

extension MultiplayerInfoViewController: AvatarImageViewDelegate {
    
    func didTapSelectAvatar() {
        Coordinator.shared.showAvatarsSelection(from: self)
    }
    
}

extension MultiplayerInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextfield.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)

        return newString.count <= maxLength
    }

}

extension MultiplayerInfoViewController: GADFullScreenContentDelegate {
    
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
      print("Ad did fail to present full screen content.")
    }

    /// Tells the delegate that the ad will present full screen content.
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Ad will present full screen content.")
    }

    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        guard let player = player else {
            return
        }
        Coordinator.shared.goToMultiPregameScreen(from: self, player: player)
    }
    
}
