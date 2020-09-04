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

    let defaults = UserDefaults.standard
    
    let books: Biblia? = nil
    var version = NVI
    var chapter = 0
    
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
        button.backgroundColor = .blueOff
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
        tableView.backgroundColor = .backViewColor
        tableView.layer.cornerRadius = 20
        tableView.layer.masksToBounds = true
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
        button.setDimensions(width: 20, height: 20)
        return button
    }()

    lazy var rightSwipeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "right"), for: .normal)
         button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(rightSwipe), for: .touchUpInside)
        button.setDimensions(width: 20, height: 20)
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
        biblia = File().readBiblia(abbrev: livro, version: NVI)
        chapter = capitulo
        
        configureUI()
        setupTableView()
        setupButtonsNav()
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
        let abbrev = biblia?.abbrev ?? ""
        if chapter > 1 {
            biblia = File().readBiblia(abbrev: abbrev, version: version)
                return
        }
        for ind in biblia!.chapters[chapter].indices where ind > 0 {
           
                biblia = File().readBiblia(abbrev: abbrev, version: version)
                return
        }
       
    }
        
    @objc func leftSwipe() {
         let abbrev = biblia?.abbrev ?? ""
           if chapter > 1 {
               biblia = File().readBiblia(abbrev: abbrev, version: version)
                   return
           }
        for ind in biblia!.chapters[chapter].indices where ind > 0 {
            biblia = File().readBiblia(abbrev: abbrev, version: version)
            return
        }
    }
    
     // MARK: Helpers

    private func configureUI() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .backgroundColor
        navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = .backgroundColor
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
        defaults.set(biblia?.abbrev ?? "", forKey: "abbr")
        defaults.set(chapter, forKey: "chapter")
    }
    
    private func showHiddenArrowsLeftRight() {
        if biblia?.abbrev == "gn" && chapter == 1 {
            leftSwipeButton.isHidden = true } else {
            leftSwipeButton.isHidden = false
        }
        
        if biblia?.abbrev == "ap" && chapter == 22 {
           rightSwipeButton.isHidden = true } else {
           rightSwipeButton.isHidden = false
       }
    }
    
    private func updateButtonTitle() {
        let buttonTitle = "\(biblia?.abbrev ?? "")"  + " " + "\(chapter)"
            titleButton.setTitle(buttonTitle, for: .normal)
            let versionButtonTitle = version.uppercased()
            versionButton.setTitle(versionButtonTitle, for: .normal)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 8,
                         paddingBottom: 0,
                         paddingRight: 8)
        tableView.register(BibliaTableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    private func setupButtonsNav() {
        let stackView = UIStackView(arrangedSubviews: [leftSwipeButton, titleButton, rightSwipeButton])
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
               
        navigationItem.titleView = stackView
    }

}

extension BibliaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        biblia?.chapters[chapter].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let myCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as?
            BibliaTableViewCell else { return UITableViewCell() }
        
        let num = "\(indexPath.row + 1)"
        let verso =  "\(biblia?.chapters[chapter][indexPath.row] ?? "")"
        
        myCell.createCell(num: num, verso: verso)
        return myCell
    }
}

extension BibliaViewController: LivrosTableViewDelegate {
    func didSelectSection(abbr: String, chapter: Int) {
        biblia = File().readBiblia(abbrev: abbr, version: version)
    }
}
