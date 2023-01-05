//
//  SoundTableViewCell.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 04/01/2023.
//

import UIKit

class SoundTableViewCell: UITableViewCell {

    private struct Margins {
        
        var top: CGFloat
        var right: CGFloat
        var left: CGFloat
        var bottom: CGFloat
        
        init() {
            if UIDevice.current.userInterfaceIdiom == .phone {
                top = 20
                right = -60
                left = 60
                bottom = 20

            } else {
                top = 20
                right = -60
                left = 60
                bottom = 20

            }
        }
    }
    
    private let margins = Margins()
    
    lazy var soundIcon : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(systemName: "speaker.wave.3.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28))
        img.tintColor = UIColor(asset: Asset.Colors.label)
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    lazy var soundSlider : CustomSlider = {
        let slider = CustomSlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.maximumValue = 10
        slider.isContinuous = false
        slider.minimumValue = 0
        slider.value = 10
        slider.tintColor = UIColor(asset: Asset.Colors.label)
        slider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
        return slider
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupSubViews()
        setupConstraints()
    }
    
    private func setupSubViews() {
        contentView.addSubview(soundIcon)
        contentView.addSubview(soundSlider)
    }
    
    private func setupConstraints() {
        let constraints = [
            soundIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: margins.left),
            soundIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            soundIcon.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            soundIcon.widthAnchor.constraint(equalTo: soundIcon.heightAnchor),
            
            soundSlider.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: margins.right),
            soundSlider.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            soundSlider.leftAnchor.constraint(equalTo: soundIcon.rightAnchor, constant: margins.left/2)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func sliderValueDidChange(_ sender: UISlider) {
        if sender.value > 7 {
            soundIcon.image = UIImage(systemName: "speaker.wave.3.fill")
        } else if sender.value > 4, sender.value < 7 {
            soundIcon.image = UIImage(systemName: "speaker.wave.2.fill")
        } else if sender.value == 0 {
            soundIcon.image = UIImage(systemName: "speaker.fill")
        } else {
            soundIcon.image = UIImage(systemName: "speaker.wave.1.fill")
        }
    }
    
}
