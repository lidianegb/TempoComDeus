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
    
    lazy var titleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blueAct
        button.setTitle("??", for: .normal)
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
                let buttonTitle = String(describing: self.biblia?.book.name)  + " " + String(describing: self.biblia?.chapter.number)
                self.titleButton.setTitle(buttonTitle, for: .normal)
                let rightButtonTitle = self.biblia?.book.version?.uppercased()
                self.rightButton.setTitle(rightButtonTitle, for: .normal)
            }
        }
    }
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        BibliaRepository().getCapitulo(livro: "job", cap: 33){
            [weak self] (biblia) in self?.biblia = biblia
        }
        configureUI()
        addBackground()
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
        view.backgroundColor = .blueBackgroud
        navigationItem.titleView = titleButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
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
        myCell.createCell(num: String(describing: biblia?.verses[indexPath.row].number) , verso: String(describing: biblia?.verses[indexPath.row].text))
        return myCell
    }
    

    
    
}


