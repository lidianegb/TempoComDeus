//
//  ConfigViewController.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 08/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController {
    
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
        
        tableView.register(ConfigSectionOneTableViewCell.self, forCellReuseIdentifier: "sectionOne")
        tableView.register(ConfigSectionTwoTableViewCell.self, forCellReuseIdentifier: "sectionTwo")
    }
    
}

extension ConfigViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = UITableViewCell()
            cell.textLabel?.text = indexPath.row == 0 ? "Tema" : "Fonte"
            cell.textLabel?.textColor = .label
            cell.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
            cell.backgroundColor = .backViewColor
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
            return cell
        }
        if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "sectionOne", for: indexPath)
                as? ConfigSectionOneTableViewCell else { return UITableViewCell() }
            return cell
            
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sectionTwo", for: indexPath)
            as? ConfigSectionTwoTableViewCell else { return UITableViewCell() }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
            return 40
        }
        return 100
    }
}
