//
//  LanguageTableViewCell.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 04/01/2023.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
