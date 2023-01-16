//
//  CustomAlertController.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 16/01/2023.
//

import UIKit
protocol CustomAlertControllerDelegate : AnyObject {
    func didTapRetry()
    func didTapLeaveGame()
}

class CustomAlertController: UIView {
    
    weak var delegate : CustomAlertControllerDelegate?
    
    private lazy var darkView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.6
        return view
    }()
    
    private lazy var wonLostLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var retryButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(asset: Asset.Colors.background)
        button.layer.cornerRadius = 5
        button.setTitle("Retry", for: .normal)
        return button
    }()
    
    private lazy var leaveButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        button.setTitle("Leave", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupButtonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(asset: Asset.Colors.orange)
        layer.cornerRadius = 8
        
        addSubview(retryButton)
        addSubview(leaveButton)
        
        let constraints = [
            retryButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            retryButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            retryButton.widthAnchor.constraint(equalToConstant: 90),
            retryButton.heightAnchor.constraint(equalToConstant: 40),
            
            leaveButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            leaveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            leaveButton.widthAnchor.constraint(equalToConstant: 90),
            leaveButton.heightAnchor.constraint(equalToConstant: 40),
            
            wonLostLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            wonLostLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: wonLostLabel.bottomAnchor, constant: 10),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupButtonActions() {
        retryButton.addAction(UIAction(handler: { _ in
            self.delegate?.didTapRetry()
        }), for: .touchUpInside)
        
        leaveButton.addAction(UIAction(handler: { _ in
            self.delegate?.didTapLeaveGame()
        }), for: .touchUpInside)
    }

    public func show(on view: UIView, win: Bool) {
        view.addSubview(darkView)
        darkView.pinToView(to: view, with: -70)
        darkView.alpha = 0
        view.addSubview(self)
        alpha = 0
        view.isUserInteractionEnabled = true
        let constraints = [
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor),
            widthAnchor.constraint(equalToConstant: 250),
            heightAnchor.constraint(equalToConstant: 180),
        ]
        transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 1, delay: 3, usingSpringWithDamping: 1, initialSpringVelocity: 1) {
            self.alpha = 1
            self.transform = CGAffineTransform.identity
            self.darkView.alpha = 0.6
        }
        NSLayoutConstraint.activate(constraints)
        
        if win {
            wonLostLabel.text = "WINNER"
            descriptionLabel.text = "Congratulations on your victory! Keep up the great work and play again"
        } else {
            wonLostLabel.text = "YOU LOST"
            descriptionLabel.text = "don't give up! Keep playing and you'll come out on top next time."
        }
    }
    
    public func hide() {
        darkView.removeFromSuperview()
        removeFromSuperview()
    }
}
