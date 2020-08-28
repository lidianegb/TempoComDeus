//
//  LivrosTableViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

protocol LivrosTableViewDelegate: class {
    func didSelectSection(abbr: String, chapter: Int)
}

class LivrosTableViewController: UIViewController {
    
    var tableData = LivrosData.data()
    var abbr: String?
      
        let cellId = "cellId"
        let cellSection = "cellSection"
    
        lazy var tableView: UITableView = {
            let tableView = UITableView(frame: .zero, style: .plain)
            tableView.backgroundColor = .backViewColor
            tableView.separatorColor = .backgroundColor
            tableView.alwaysBounceVertical = false
            tableView.alwaysBounceHorizontal = false
            tableView.delegate = self
            tableView.dataSource = self
            return tableView
        }()
    
   weak var delegate: LivrosTableViewDelegate?

    let cancelButton: UIButton = {
           let button = UIButton()
           button.setTitle("Cancelar", for: .normal)
           button.setTitleColor(.blueAct, for: .normal)
           button.addTarget(self, action: #selector(cancelar), for: .touchUpInside)
           return button
       }()
    
    let labelTitle: UILabel = {
        let label = UILabel()
        label.text = "Livros"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
       
    }

    func configureUI() {
        view.backgroundColor = .backViewColor
        setupTableView()
        addHeader()
    }
    
    @objc func cancelar() {
        self.dismiss(animated: true, completion: nil)
    }

    func addHeader() {
        view.insertSubview(cancelButton, at: 1)
        cancelButton.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        view.insertSubview(labelTitle, at: 1)
        labelTitle.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: 16)
    }
    
    func setupTableView() {
        tableView.register(CapitulosTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.register(LivrosTableViewSections.self, forCellReuseIdentifier: cellSection)
        view.insertSubview(tableView, at: 0)
        tableView.anchor(top: view.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 50,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0)
    }
    
}

extension LivrosTableViewController: UITableViewDelegate, UITableViewDataSource {
     func numberOfSections(in tableView: UITableView) -> Int {
       tableData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if tableData[section].opened == true {
                return 2 } else {
                return 1
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellSection) as?
                LivrosTableViewSections else { return UITableViewCell()}
                cell.textLabel?.text = tableData[indexPath.section].title
                cell.didSelected(isSelected: tableData[indexPath.section].opened)
                cell.createCell()
            return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId)  as?
                    CapitulosTableViewCell else { return UITableViewCell()}
            cell.delegate = self
            cell.createCell(items: tableData[indexPath.section].items)
                return cell
            }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableData[indexPath.section].opened == true {
            tableData[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none) } else {
            tableData[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
         
        }
        self.abbr = tableData[indexPath.section].abbrev
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
           return 44
        } else {
            let items = Double(tableData[indexPath.section].items)
            return calculaHeight(qtdItems: items)
        }
    }
    
    func calculaHeight(qtdItems: Double) -> CGFloat {
        let heigth = ceil(qtdItems / 7.0)
        return CGFloat( heigth == 1 ? 70 : heigth * 50 + 20 )
    }
}

extension LivrosTableViewController: CapitulosTableViewCellDelegate {
    func didTap(chapter: Int) {
        
        self.delegate?.didSelectSection(abbr: self.abbr ?? " ", chapter: chapter)
        self.dismiss(animated: true, completion: nil)
    }
    
}
   
