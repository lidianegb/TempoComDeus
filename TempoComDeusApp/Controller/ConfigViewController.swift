//
//  ConfigViewController.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 08/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController {
    
    let sectionOne = "sectionOne"
    let sectionTwo = "sectionTwo"
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .backgroundColor
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        return tableView
    }()
    
    let titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Ajustes"
        label.textColor = .label
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .backgroundColor
        navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = .backgroundColor
        navigationItem.titleView = titleLabel
        setupTableView()
        
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.insertSubview(tableView, at: 0)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 8,
                         paddingBottom: 0,
                         paddingRight: 8)
        
        tableView.register(ConfigSectionOneTableViewCell.self, forCellReuseIdentifier: sectionOne)
        tableView.register(ConfigSectionTwoTableViewCell.self, forCellReuseIdentifier: sectionTwo)
    }
    
}

extension ConfigViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: sectionOne, for: indexPath)
                as? ConfigSectionOneTableViewCell else { return UITableViewCell() }
            return cell
            
        }
        if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: sectionTwo, for: indexPath)
                as? ConfigSectionTwoTableViewCell else { return UITableViewCell() }
            cell.setupFonteSize()
            return cell
        }
        
        let cell = UITableViewCell()
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        cell.backgroundColor = .backViewColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        }
        if indexPath.row == 1 {
            return 100
        }
        
        return CGFloat(tableView.frame.height - 150)
    }
}
