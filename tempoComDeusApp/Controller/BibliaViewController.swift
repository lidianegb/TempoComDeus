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
    
    let titleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blueAct
        button.setTitle("??", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.tintColor = .white
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setDimensions(width: 120, height: 25)
        button.addTarget(self, action: #selector(showLivros), for: .touchUpInside)
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

  
    
    var biblia = Biblia(book: Livro(abbrev: ["pt": "", "en": ""], name: "", author: "", chapters: 0, group: "", testament: "", version: ""), chapter: Capitulo(number: 0, verses: 0), verses: [Verso(number: 0, text: ""), Verso(number: 0, text: "")]){
        didSet{
            DispatchQueue.main.async {
               self.tableView.reloadData()
                let buttonTitle = self.biblia.book.name + " " + String(describing: self.biblia.chapter.number)
                self.titleButton.setTitle(buttonTitle, for: .normal)
            }
        }
    }
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        BibliaRepository().getCapitulo(livro: "gn", cap: 1){
            [weak self] (biblia) in self?.biblia = biblia
        }
        configureUI()
        addBackground()
        addTitleButton()
        setupTableView()
      
    }
    
    // MARK: Selectors

    @objc func showLivros(){
        print("cliclou")
        let livrosTableView = LivrosTableView()
        self.present(livrosTableView, animated: true)
    }
     
     // MARK: Helpers
    
    func configureUI(){
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .blueBackgroud
    }
    
    func addTitleButton(){
        backView.addSubview(titleButton)
        titleButton.centerX(inView: backView, topAnchor: backView.topAnchor, paddingTop: 10)
    }
    
    func addBackground(){
        view.insertSubview(backView, at: 0)
        backView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8)
    }
    
    func setupTableView(){
        view.insertSubview(tableView, at: 1)
        tableView.anchor(top: titleButton.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 8, paddingBottom: 0, paddingRight: 8)
        tableView.register(BibliaTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    

}

extension BibliaViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         biblia.verses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BibliaTableViewCell
        myCell.createCell(num: "\(String(describing: biblia.verses[indexPath.row].number))" , verso: biblia.verses[indexPath.row].text)
        return myCell
    }
    

    
    
}


