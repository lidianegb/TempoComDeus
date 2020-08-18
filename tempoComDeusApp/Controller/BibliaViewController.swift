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
    
     
    
  
    
    var biblia = Biblia(book: Livro(abbrev: ["pt": "", "en": ""], name: "", author: "", chapters: 0, group: "", testament: "", version: ""), chapter: ["numero": 0, "versos": 0], verses: [Verso(number: 0, text: "Deus te ama Deus te ama Deus te ama Deus te ama Deus te ama Deus te ama Deus te ama Deus te ama Deus te ama Deus te ama Deus te ama Deus te ama Deus te ama Deus te ama"), Verso(number: 0, text: "Deus te ama Deus te ama Deus te ama Deus te ama Deus te ama Deus te ama Deus te ama Deus te ama Deus te ama Deus te ama Deus te ama Deus te ama Deus te ama Deus te ama")]){
        didSet{
            DispatchQueue.main.async {
               self.tableView.reloadData()
            }
        }
    }
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

      
       
        BibliaRepository().getCapitulo(livro: "lc", cap: 2){
            [weak self] (biblia) in self?.biblia = biblia
        }
        configureUI()
        addBackground()
        setupTableView()
    }
    
    // MARK: Selectors

    
     
     // MARK: Helpers
    
    func configureUI(){
        navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = .blueBackgroud
        navigationItem.title = "biblia"
    }
    
    func addBackground(){
        let backView = BackView()
        view.insertSubview(backView, at: 0)
        backView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8)
    }
    
    func setupTableView(){
        view.insertSubview(tableView, at: 1)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8)
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


