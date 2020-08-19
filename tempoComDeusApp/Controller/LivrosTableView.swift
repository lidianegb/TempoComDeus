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
    
    let cancelButton : UIButton = {
           let button = UIButton()
           button.setTitle("Cancelar", for: .normal)
           button.setTitleColor(.blueAct, for: .normal)
           button.addTarget(self, action: #selector(cancelar), for: .touchUpInside)
           return button
       }()
    
    let labelTitle: UILabel = {
        let label = UILabel()
        label.text = "Livros"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
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
        setupTableView()
        addHeader()
    }

    @objc func cancelar(){
        self.dismiss(animated: true, completion: nil)
    }

    
    func addHeader(){
        view.insertSubview(cancelButton, at: 1)
        cancelButton.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        view.insertSubview(labelTitle, at: 1)
        labelTitle.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: 16)
    }
    
    func setupTableView(){
        view.insertSubview(tableView, at: 0)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    

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
