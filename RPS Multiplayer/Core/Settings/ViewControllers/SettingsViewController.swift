//
//  SettingsViewController.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 04/01/2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.registerCell(MusicTableViewCell.self)
        table.registerCell(SoundTableViewCell.self)
        table.registerCell(LanguageTableViewCell.self)
        table.isUserInteractionEnabled = true
        table.separatorColor = .clear
        table.isScrollEnabled = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(asset: Asset.Colors.background)
        setupUI()
    }
    
    private func setupUI() {
        setupNavigationBar()
        setupSubviews()
        setupConstraints()
    }

    private func setupNavigationBar() {
        title = L10n.Settings.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor(asset: Asset.Colors.label)
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupConstraints() {
        tableView.pinToView(to: view, with: 0)
    }
    
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 : return tableView.dequeResuableCell(for: MusicTableViewCell.self, for: indexPath)
        case 1 : return tableView.dequeResuableCell(for: SoundTableViewCell.self, for: indexPath)
        case 2 : return tableView.dequeResuableCell(for: LanguageTableViewCell.self, for: indexPath)
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0 : return 75
        case 1 : return 75
        case 2 : return 0
        default:
            break
        }
        return 0
    }
}
