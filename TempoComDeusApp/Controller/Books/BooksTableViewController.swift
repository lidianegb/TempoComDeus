//
//  BooksTableViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.

import UIKit

class BooksTableViewController: UIViewController {
    
    var tableData = [Book]()
    var abbreviation: String?
    var data = Bible()
    let cellId = "cellId"
    let cellSection = "cellSection"
    let searchBar = UISearchBar()
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
    
    var onDidSelectSection: ((_ abbreviation: String, _ chapter: Int) -> Void)?
    
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
        setupSearchController()
        tableData = data.allBooks
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func configureUI() {
        view.backgroundColor = .backViewColor
        addHeader()
        setupTableView()
    }
    
    @objc func cancelar() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addHeader() {
        view.addSubview(cancelButton)
        cancelButton.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        view.addSubview(labelTitle)
        labelTitle.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: 16)
        
        view.addSubview(searchBar)
        searchBar.anchor(top: labelTitle.bottomAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingTop: 8, paddingLeft: 16, paddingRight: 16)
    }
    
    func setupSearchController() {
        searchBar.delegate = self
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "Buscar livros"
        searchBar.sizeToFit()
        searchBar.backgroundColor = .backViewColor
        searchBar.searchTextField.backgroundColor = .backgroundColor
        searchBar.isTranslucent = true
        searchBar.backgroundImage = UIImage()
    }
    
    func setupTableView() {
        tableView.register(ChaptersTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.register(BooksTableViewSections.self, forCellReuseIdentifier: cellSection)
        view.insertSubview(tableView, at: 0)
        tableView.anchor(top: searchBar.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 8,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0)
    }
    
    func didTap(chapter: Int) {
        onDidSelectSection?(self.abbreviation ?? "gn", chapter)
        self.dismiss(animated: true, completion: nil)
    }
    
}
