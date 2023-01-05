//
//  MusicTableViewCell.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 04/01/2023.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    
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
    
    lazy var musicIcon : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(systemName: "music.note", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28))
        img.tintColor = UIColor(asset: Asset.Colors.label)
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    lazy var musicSlider : CustomSlider = {
        let slider = CustomSlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.maximumValue = 10
        slider.isContinuous = false
        slider.minimumValue = 0
        slider.value = 10
        slider.isUserInteractionEnabled = true
        slider.tintColor = UIColor(asset: Asset.Colors.label)
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
        contentView.addSubview(musicIcon)
        contentView.addSubview(musicSlider)
    }
    
    private func setupConstraints() {
        let constraints = [
            musicIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: margins.left),
            musicIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            musicIcon.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            musicIcon.widthAnchor.constraint(equalTo: musicIcon.heightAnchor),
            
            musicSlider.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: margins.right),
            musicSlider.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            musicSlider.leftAnchor.constraint(equalTo: musicIcon.rightAnchor, constant: margins.left/2)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
