//
//  LivrosTableView.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit


class LivrosTableView: UIViewController {
    
    var tableData = CellData.data()
    
        var livros: [Livro] = []{
              didSet{
                  DispatchQueue.main.async {
                     self.tableView.reloadData()
                  }
              }
        }

      
        let cellId = "cellId"
        let cellSection = "cellSection"
    
        lazy var tableView: UITableView = {
            let tableView = UITableView(frame: .zero, style: .plain)
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
        tableView.register(LivrosTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.register(SectionLivrosTableViewCell.self, forCellReuseIdentifier: cellSection)
        view.insertSubview(tableView, at: 0)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    

}

extension LivrosTableView: UITableViewDelegate, UITableViewDataSource{
     func numberOfSections(in tableView: UITableView) -> Int {
       tableData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if tableData[section].opened == true{
                return 5
            }else{
                return 1
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellSection) as? SectionLivrosTableViewCell else { return UITableViewCell()}
                cell.textLabel?.text = tableData[indexPath.section].title
                cell.configure()
            return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId)  as? LivrosTableViewCell else { return UITableViewCell()}
                cell.textLabel?.text = "\(tableData[indexPath.section].items)"
                cell.configure()
                return cell
            }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableData[indexPath.section].opened == true{
            tableData[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }else{
            tableData[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
         
        }
    }
}
