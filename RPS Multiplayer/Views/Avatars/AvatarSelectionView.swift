//
//  AvatarSelectionView.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 08/01/2023.
//

import UIKit

class AvatarSelectionView: UIViewController {
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout().exploreLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.registerCell(AvatarCollectionViewCell.self)
        collectionView.backgroundColor = UIColor(asset: Asset.Colors.background)
        collectionView.isScrollEnabled = true
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(asset: Asset.Colors.background)
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupConstraints() {
        collectionView.pinToView(to: view, with: 0)
    }
    
}

extension AvatarSelectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Data.shared.avatars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeResuableCell(for: AvatarCollectionViewCell.self, for: indexPath)
        cell.configure(with: Data.shared.avatars[indexPath.row])
        cell.isUserInteractionEnabled = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name("didChangeAvatar"), object: Data.shared.avatars[indexPath.row])
    }
    
}
