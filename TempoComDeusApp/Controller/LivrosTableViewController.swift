//
//  LivrosTableViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class LivrosTableViewController: UIViewController {
    
    var tableData: [Biblia] = File().readBiblia() 
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

extension LivrosTableViewController: CapitulosTableViewCellDelegate {
    func didTap(chapter: Int) {
        
        self.delegate?.didSelectSection(abbr: self.abbr ?? " ", chapter: chapter)
        self.dismiss(animated: true, completion: nil)
    }
    
}
