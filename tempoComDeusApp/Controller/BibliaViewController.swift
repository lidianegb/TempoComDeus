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
    
    let books = CellData.data()
    
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
    
    lazy var rightButton: UIButton = {
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

    lazy var rightSwipeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "left"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(rightSwipe), for: .touchUpInside)
        return button
    }()

    lazy var leftSwipeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "right"), for: .normal)
         button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(leftSwipe), for: .touchUpInside)
        return button
    }()
    
    var biblia: Biblia? {
        didSet {
            DispatchQueue.main.async {
               self.tableView.reloadData()
                self.updateValues()
                self.updateButtonTitle()
                self.showHiddenArrowLeftRight()
            }
        }
    }
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialValues()
        let livro = defaults.string(forKey: "abbr") ?? ""
        let chapter = defaults.integer(forKey: "chapter")
        BibliaRepository().getCapitulo(livro: livro, cap: chapter) { [weak self] (biblia) in self?.biblia = biblia }
        configureUI()
        addBackground()
        setupTableView()
        addButtonsSwipe()
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        view.addGestureRecognizer(rightSwipe)
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
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
               rightSwipe()
            case .left:
                leftSwipe()
            default:
                break
            }
        }
    }
     
     // MARK: Helpers

    func configureUI() {
        navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = .blueBackgroud
        navigationItem.titleView = titleButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
    
    func setupInitialValues() {
      
        if defaults.value(forKey: "abbr") as? String != nil { } else {
            defaults.set("gn", forKey: "abbr")
        }
        if defaults.value(forKey: "chapter") as? Int != nil { } else {
            defaults.set(1, forKey: "chapter")
        }
    }
    
    func showHiddenArrowLeftRight() {
        if biblia?.book.abbrev["pt"] == "gn" && biblia?.chapter.number == 1 {
            rightSwipeButton.isHidden = true } else {
            rightSwipeButton.isHidden = false
        }
        
        if biblia?.book.abbrev["pt"] == "ap" && biblia?.chapter.number == 22 {
           leftSwipeButton.isHidden = true } else {
           leftSwipeButton.isHidden = false
       }
    }
    
    @objc func leftSwipe() {
        for (ind, book) in books.enumerated() {
            let abbrev = biblia?.book.abbrev["pt"] ?? ""
            let chapter = biblia?.chapter.number ?? 0
            if book.abbrev == abbrev {
                if chapter < book.items {
                    BibliaRepository().getCapitulo(livro: abbrev, cap: chapter + 1) {[weak self] (biblia) in
                        self?.biblia = biblia
                    }
                     return
                }
                
                if ind < (books.count - 1) {
                    BibliaRepository().getCapitulo(livro: books[ind + 1].abbrev, cap: 1) { [weak self] (biblia) in
                        self?.biblia = biblia
                   }
                   return
                }
            }
        }
    }
    @objc func rightSwipe() {
        for (ind, book) in books.enumerated() {
           let abbrev = biblia?.book.abbrev["pt"] ?? ""
            let chapter = biblia?.chapter.number ?? 0
           if book.abbrev == abbrev {
               if chapter > 1 {
                   BibliaRepository().getCapitulo(livro: abbrev, cap: chapter - 1) {[weak self] (biblia) in
                    self?.biblia = biblia
                   }
                    return
               }
               
               if ind > 0 {
                BibliaRepository().getCapitulo(livro: books[ind - 1].abbrev,
                                               cap: books[ind - 1].items) { [weak self] (biblia) in
                    self?.biblia = biblia
                }
                return
               }
           }
       }
    }
    
    func updateValues() {
        defaults.set(biblia?.book.abbrev["pt"] ?? "", forKey: "abbr")
        defaults.set(biblia?.chapter.number, forKey: "chapter")
    }
    func updateButtonTitle() {
        let buttonTitle = "\(biblia?.book.name ?? "")"  + " " + "\(biblia?.chapter.number ?? 0)"
            titleButton.setTitle(buttonTitle, for: .normal)
            let rightButtonTitle = self.biblia?.book.version?.uppercased()
            rightButton.setTitle(rightButtonTitle, for: .normal)
    }
    
    func addBackground() {
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
    
    func setupTableView() {
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
    
    func addButtonsSwipe() {
        view.addSubview(rightSwipeButton)
        rightSwipeButton.anchor(left: view.leftAnchor,
                                bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                paddingLeft: 10,
                                paddingBottom: 10,
                                width: 20,
                                height: 20)
        
        view.addSubview(leftSwipeButton)
        leftSwipeButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
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
        myCell.createCell(num: "\(biblia?.verses[indexPath.row].number ?? 0)",
            verso: "\(biblia?.verses[indexPath.row].text ?? " ")" )
        return myCell
    }
}

extension BibliaViewController: LivrosTableViewDelegate {
    func didSelectSection(abbr: String, chapter: Int) {
         BibliaRepository().getCapitulo(livro: abbr, cap: chapter) { [weak self] (biblia) in
            self?.biblia = biblia
        }
    }
}
