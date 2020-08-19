//
//  LivrosTableTableView.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class LivrosTableTableView: UIViewController {

      lazy var tableView: UITableView = {
          let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
          tableView.alwaysBounceVertical = false
          tableView.alwaysBounceHorizontal = false
          tableView.delegate = self
          tableView.dataSource = self
          return tableView
      }()
    
  var livros: [Livro] = []{
        didSet{
            DispatchQueue.main.async {
               self.tableView.reloadData()
            }
        }
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        BibliaRepository().getLivros(){
            [weak self] (livros) in self?.livros = livros
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}

extension LivrosTableView: UITableViewDelegate, UITableViewDataSource{
    
}
