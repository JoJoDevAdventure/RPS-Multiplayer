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
    
    private lazy var centerMark: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    private lazy var avatar1Image: UIImage = {
        let image = UIImage()
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
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
            centerMark.widthAnchor.constraint(equalTo: progressionBar.widthAnchor, constant: 10)
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
        
    }
    
    public func resetScore() {
        
    }
    
}
