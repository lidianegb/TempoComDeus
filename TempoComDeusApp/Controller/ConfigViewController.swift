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
        tableView.backgroundColor = .backViewColor
        tableView.layer.cornerRadius = 20
        tableView.layer.masksToBounds = true
        tableView.separatorStyle = .none
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
    }

}

extension ConfigViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerSectionView = UIView()
        headerSectionView.backgroundColor = .blueOff
        let titleHeaderSection = UILabel()
        titleHeaderSection.textColor = .label
        titleHeaderSection.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleHeaderSection.textAlignment = .left
        titleHeaderSection.text = section == 0 ? "Tema" : "Tamanho da fonte"
        headerSectionView.addSubview(titleHeaderSection)
        titleHeaderSection.anchor(top: headerSectionView.topAnchor,
                          left: headerSectionView.leftAnchor,
                          paddingTop: 5,
                          paddingLeft: 16)
        return headerSectionView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
