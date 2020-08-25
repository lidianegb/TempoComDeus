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
    
    let books = LivrosData.data()
    
    lazy var titleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blueAct
        button.setTitle("", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.tintColor = .white
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setDimensions(width: 150, height: 30)
        button.addTarget(self, action: #selector(showLivros), for: .touchUpInside)
        return button
    }()
    
    lazy var versionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blueClear
        button.setTitle("", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.tintColor = .white
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setDimensions(width: 40, height: 30)
        return button
       }()
    
     lazy var tableView: UITableView = {
       let tableView = UITableView(frame: .zero, style: .grouped)
           tableView.backgroundColor = .clear
            tableView.separatorStyle = .none
            tableView.allowsSelection = false
           tableView.alwaysBounceVertical = false
           tableView.alwaysBounceHorizontal = false
           tableView.delegate = self
           tableView.dataSource = self
        return tableView
       }()

    lazy var leftSwipeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "left"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(leftSwipe), for: .touchUpInside)
        return button
    }()

    lazy var rightSwipeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "right"), for: .normal)
         button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(rightSwipe), for: .touchUpInside)
        return button
    }()
    
    var biblia: Biblia? {
        didSet {
            DispatchQueue.main.async {
               self.tableView.reloadData()
                self.updateDefaultsValues()
                self.updateButtonTitle()
                self.showHiddenArrowsLeftRight()
            }
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultsValues()
        
        let livro = defaults.string(forKey: "abbr") ?? ""
        let capitulo = defaults.integer(forKey: "chapter")
        buscarDados(livroAbrev: livro, cap: capitulo)
        
        configureUI()
        setupBackView()
        setupTableView()
        setupButtonsSwipe()
        
        setupSwipeGestures()
    }
    
    // MARK: Selectors
    @objc func showLivros() {
        let livrosTableView = LivrosTableViewController()
        livrosTableView.delegate = self
        self.present(livrosTableView, animated: true)
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .right:
               leftSwipe()
            case .left:
                rightSwipe()
            default:
                break
            }
        }
    }
    
    @objc func rightSwipe() {
        for (ind, book) in books.enumerated() {
          let abbrev = biblia?.book.abbrev["pt"] ?? ""
           let chapter = biblia?.chapter.number ?? 0
            if book.abbrev == abbrev {
              
                if chapter > 1 {
                    buscarDados(livroAbrev: abbrev, cap: chapter + 1)
                    return
                }
                
                if ind > 0 {
                    buscarDados(livroAbrev: books[ind + 1].abbrev, cap: books[ind + 1].items)
                    return
                }
            }
        }
    }
    
    @objc func leftSwipe() {
        for (ind, book) in books.enumerated() {
          let abbrev = biblia?.book.abbrev["pt"] ?? ""
           let chapter = biblia?.chapter.number ?? 0
            if book.abbrev == abbrev {
              
                if chapter > 1 {
                    buscarDados(livroAbrev: abbrev, cap: chapter - 1)
                    return
                }
                
                if ind > 0 {
                    buscarDados(livroAbrev: books[ind - 1].abbrev, cap: books[ind - 1].items)
                    return
                }
            }
        }
    }
    
     // MARK: Helpers

    private func configureUI() {
        navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = .blueBackgroud
        navigationItem.titleView = titleButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: versionButton)
    }
    
    private func setupSwipeGestures() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        view.addGestureRecognizer(rightSwipe)
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
    }
    
    private func setupDefaultsValues() {
      
        if defaults.value(forKey: "abbr") as? String != nil { } else {
            defaults.set("gn", forKey: "abbr")
        }
        if defaults.value(forKey: "chapter") as? Int != nil { } else {
            defaults.set(1, forKey: "chapter")
        }
    }
    
    private func updateDefaultsValues() {
        defaults.set(biblia?.book.abbrev["pt"] ?? "", forKey: "abbr")
        defaults.set(biblia?.chapter.number, forKey: "chapter")
    }
    
    private func showHiddenArrowsLeftRight() {
        if biblia?.book.abbrev["pt"] == "gn" && biblia?.chapter.number == 1 {
            leftSwipeButton.isHidden = true } else {
            leftSwipeButton.isHidden = false
        }
        
        if biblia?.book.abbrev["pt"] == "ap" && biblia?.chapter.number == 22 {
           rightSwipeButton.isHidden = true } else {
           rightSwipeButton.isHidden = false
       }
    }
    
    private func buscarDados(livroAbrev: String, cap: Int) {
        BibliaRepository().getCapitulo(
           livro: livroAbrev, cap: cap) {[weak self] (biblia) in self?.biblia = biblia }
    }
    
    private func updateButtonTitle() {
        let buttonTitle = "\(biblia?.book.name ?? "")"  + " " + "\(biblia?.chapter.number ?? 0)"
            titleButton.setTitle(buttonTitle, for: .normal)
            let versionButtonTitle = self.biblia?.book.version?.uppercased()
            versionButton.setTitle(versionButtonTitle, for: .normal)
    }
    
    private func setupBackView() {
         view.addSubview(backView)
        backView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        left: view.leftAnchor,
                        bottom: view.safeAreaLayoutGuide.bottomAnchor,
                        right: view.rightAnchor,
                        paddingTop: 0,
                        paddingLeft: 8,
                        paddingBottom: 0,
                        paddingRight: 8)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor,
                         left: view.leftAnchor,
                         bottom: backView.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 10,
                         paddingLeft: 8,
                         paddingBottom: 0,
                         paddingRight: 8)
        tableView.register(BibliaTableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    private func setupButtonsSwipe() {
        view.addSubview(leftSwipeButton)
        leftSwipeButton.anchor(left: view.leftAnchor,
                                bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                paddingLeft: 10,
                                paddingBottom: 10,
                                width: 20,
                                height: 20)
        
        view.addSubview(rightSwipeButton)
        rightSwipeButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                               right: view.rightAnchor,
                               paddingBottom: 10,
                               paddingRight: 10,
                               width: 20,
                               height: 20)
    }

}

extension BibliaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        biblia?.verses.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let myCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as?
            BibliaTableViewCell else { return UITableViewCell() }
        
        let num = "\(biblia?.verses[indexPath.row].number ?? 0)"
        let verso =  "\(biblia?.verses[indexPath.row].text ?? " ")"
        
        myCell.createCell(num: num,verso: verso)
        return myCell
    }
}

extension BibliaViewController: LivrosTableViewDelegate {
    func didSelectSection(abbr: String, chapter: Int) {
         buscarDados(livroAbrev: abbr, cap: chapter)
    }
}
