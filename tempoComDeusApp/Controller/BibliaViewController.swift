//
//  BibliaViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class BibliaViewController: UIViewController {

    // MARK: Properties
    let cellId = "CellId"
    let backView = BackView()
    let defaults = UserDefaults.standard
    
    lazy var titleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blueAct
        button.setTitle("", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.tintColor = .white
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setDimensions(width: 150, height: 20)
        button.addTarget(self, action: #selector(showLivros), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButton: UIButton = {
           let button = UIButton()
           button.backgroundColor = .systemGray
           button.setTitle("??", for: .normal)
           button.titleLabel?.textAlignment = .center
           button.titleLabel?.tintColor = .white
           button.layer.cornerRadius = 5
           button.layer.masksToBounds = true
           button.setDimensions(width: 40, height: 20)
           return button
       }()
    
     lazy var tableView: UITableView = {
       let tableView = UITableView(frame: .zero, style: .grouped)
           tableView.backgroundColor = .clear
            tableView.separatorStyle = .none
           tableView.alwaysBounceVertical = false
           tableView.alwaysBounceHorizontal = false
           tableView.delegate = self
           tableView.dataSource = self
            tableView.allowsSelection = false
        return tableView
       }()

  
    
    var biblia: Biblia? {
        didSet{
            DispatchQueue.main.async {
               self.tableView.reloadData()
                self.updateValues()
                self.updateButtonTitle()
            }
        }
    }
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialValues()
        let livro = defaults.string(forKey: "abbr") ?? ""
        let chapter = defaults.integer(forKey: "chapter")
        BibliaRepository().getCapitulo(livro: livro, cap: chapter){
            [weak self] (biblia) in self?.biblia = biblia
        }
        configureUI()
        addBackground()
        setupTableView()
     
      
    }
    
    // MARK: Selectors


    @objc func showLivros(){
        let livrosTableView = LivrosTableViewController()
        livrosTableView.delegate = self
        self.present(livrosTableView, animated: true)
    }
     
     // MARK: Helpers
  
    
    func configureUI(){
        navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = .blueBackgroud
        navigationItem.titleView = titleButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
    
    func setupInitialValues(){
      
        if let _ = defaults.value(forKey: "abbr") as? String {
        }else {
            defaults.set("gn", forKey: "abbr")
        }
        if let _ = defaults.value(forKey: "chapter") as? Int {
        }else {
            defaults.set(1, forKey: "chapter")
        }
    }
    
    func updateValues(){
        defaults.set(biblia?.book.abbrev["pt"] ?? "", forKey: "abbr")
        defaults.set(biblia?.chapter.number, forKey: "chapter")
    }
    func updateButtonTitle(){
        let buttonTitle = "\(biblia?.book.name ?? "")"  + " " + "\(biblia?.chapter.number ?? 0)"
            titleButton.setTitle(buttonTitle, for: .normal)
            let rightButtonTitle = self.biblia?.book.version?.uppercased()
            rightButton.setTitle(rightButtonTitle, for: .normal)
    }
    
    func addBackground(){
         view.addSubview(backView)
        backView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8)
    }
    
    func setupTableView(){
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: backView.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 8, paddingBottom: 0, paddingRight: 8)
        tableView.register(BibliaTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    

}

extension BibliaViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        biblia?.verses.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BibliaTableViewCell
        myCell.createCell(num: "\(biblia?.verses[indexPath.row].number ?? 0)" , verso: "\(biblia?.verses[indexPath.row].text ?? " ")" )
        return myCell
    }
    

    
    
}


extension BibliaViewController: LivrosTableViewDelegate{
    func didSelectSection(abbr: String, chapter: Int) {
         BibliaRepository().getCapitulo(livro: abbr, cap: chapter){
        [weak self] (biblia) in self?.biblia = biblia
        }
    }
}
