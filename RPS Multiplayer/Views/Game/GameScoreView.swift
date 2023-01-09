//
//  GameScoreView.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 09/01/2023.
//

import UIKit

class GameScoreView: UIView {

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
        
    }
    
    private func setupConstraints() {
        
    }
    
    private func setupFunc() {
        
    }

}

// MARK: Public func
extension GameScoreView {
    
    public func addViewOn(_ view: UIView) {
        view.addSubview(self)
        let constraints : [NSLayoutConstraint] = [
            //TODO: add score view constraints
            
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
