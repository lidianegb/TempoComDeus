//
//  LivrosTableView.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class LivrosTableView: UIViewController {

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

        view.backgroundColor = .white
        BibliaRepository().getLivros(){
            [weak self] (livros) in self?.livros = livros
        }
    }

    // MARK: - Table view data source


}

extension LivrosTableView: UITableViewDelegate, UITableViewDataSource{
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return livros.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return livros[section].chapters ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           return UITableViewCell()
       }
}
