//
//  GameScoreView.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 09/01/2023.
//

import UIKit

class GameScoreView: UIView {
    
    private lazy var progressionBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.4
        return view
    }()
    
    private lazy var player1Score: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var player2Score: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var centerMark: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    private lazy var avatar1Image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(asset: Asset.Images.Avatars.avatar1)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 60).isActive = true
        image.heightAnchor.constraint(equalToConstant: 60).isActive = true
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var avatar2Image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(asset: Asset.Images.Avatars.avatar1)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 60).isActive = true
        image.heightAnchor.constraint(equalToConstant: 60).isActive = true
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        return image
    }()

    init(player1: Player, player2: Player) {
        super.init(frame: .zero)
        avatar1Image.image = player1.avatar.image
        avatar2Image.image = player2.avatar.image
        player1Score.backgroundColor = player1.avatar.mainColor
        player2Score.backgroundColor = player2.avatar.mainColor
        setupUI()
        setupFunc()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI () {
        setupSubviews()
        setupConstraints()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupSubviews() {
        addSubview(progressionBar)
        addSubview(player1Score)
        addSubview(player2Score)
        addSubview(avatar1Image)
        addSubview(avatar2Image)
        addSubview(centerMark)
    }
    
    private func setupConstraints() {
        let constraints = [
            progressionBar.topAnchor.constraint(equalTo: topAnchor),
            progressionBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            progressionBar.widthAnchor.constraint(equalToConstant: 10),
            progressionBar.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            centerMark.centerYAnchor.constraint(equalTo: progressionBar.centerYAnchor),
            centerMark.heightAnchor.constraint(equalToConstant: 5),
            centerMark.centerXAnchor.constraint(equalTo: progressionBar.centerXAnchor),
            centerMark.widthAnchor.constraint(equalTo: progressionBar.widthAnchor, constant: 10),
            
            avatar1Image.topAnchor.constraint(equalTo: progressionBar.topAnchor, constant: -10),
            avatar1Image.centerXAnchor.constraint(equalTo: progressionBar.centerXAnchor),
            

            
            avatar2Image.bottomAnchor.constraint(equalTo: progressionBar.bottomAnchor, constant: 10),
            avatar2Image.centerXAnchor.constraint(equalTo: progressionBar.centerXAnchor),
            

        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupPlayer1Score(Score: Int) {
        player1Score.removeFromSuperview()
        addSubview(player1Score)
        bringSubviewToFront(avatar1Image)
        bringSubviewToFront(centerMark)
        var height = 0.0
        switch Score {
        case 0 : height = 0
        case 1 : height = 0.333
        case 2 : height = 0.666
        case 3 : height = 1
        default : break
        }
        let constraints = [
            player1Score.heightAnchor.constraint(equalTo: progressionBar.heightAnchor, multiplier: CGFloat(height/2)),
            player1Score.widthAnchor.constraint(equalTo: progressionBar.widthAnchor),
            player1Score.topAnchor.constraint(equalTo: progressionBar.topAnchor),
            player1Score.centerXAnchor.constraint(equalTo: progressionBar.centerXAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupPlayer2Score(Score: Int) {
        player2Score.removeFromSuperview()
        addSubview(player2Score)
        bringSubviewToFront(avatar2Image)
        bringSubviewToFront(centerMark)
        var height = 0.0
        switch Score {
        case 0 : height = 0
        case 1 : height = 0.333
        case 2 : height = 0.666
        case 3 : height = 1
        default : break
        }
        let constraints = [
            player2Score.heightAnchor.constraint(equalTo: progressionBar.heightAnchor, multiplier: CGFloat(height/2)),
            player2Score.widthAnchor.constraint(equalTo: progressionBar.widthAnchor),
            player2Score.bottomAnchor.constraint(equalTo: progressionBar.bottomAnchor),
            player2Score.centerXAnchor.constraint(equalTo: progressionBar.centerXAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupFunc() {
        
    }

}

// MARK: Public func
extension GameScoreView {
    
    public func addViewOn(_ view: UIView) {
        view.addSubview(self)
        let constraints : [NSLayoutConstraint] = [
            heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            widthAnchor.constraint(equalToConstant: 40),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    public func hideView() {
        self.removeFromSuperview()
    }
    
    public func setScore(player1 score1: Int, player2 score2: Int) {
        setupPlayer1Score(Score: score1)
        setupPlayer2Score(Score: score2)
    }
    
    public func resetScore() {
        
    }
    
}
