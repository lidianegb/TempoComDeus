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
    
    let dataPicker = [NVI, AA, ACF]
    
    let cellId = "CellId"
    let defaults = UserDefaults.standard
    var version: String = NVI
    var abbrev: String = "gn"
    let biblia = File().readBiblia()
    var chapter: Int = 0 {
        didSet {
            showHiddenArrowsLeftRight()
            updateDefaultValues()
            updateButtonTitle()
            tableView.reloadData()
        }
    }
    var allLivros: [Livro] = []
    var livroAtual: Livro? {
        didSet {
            updateDefaultValues()
            updateButtonTitle()
            showHiddenArrowsLeftRight()
            tableView.reloadData()
        }
    }
    
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
        button.backgroundColor = .blueAct
        button.setTitle("", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.tintColor = .white
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
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
    
    let picker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .backViewColor
        pickerView.showsLargeContentViewer = true
        return pickerView
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDefaultsValues()
        abbrev = getDefaultAbbrev()
        version = getDefaultVersion()
        chapter = getDefaultChapter()
        
        allLivros = File().readBibleByVersion(version: version)
        
        livroAtual = getLivroAtual(abreviacao: abbrev)
        
        configureUI()
      
        setupTableView()
        setupPicker()
        picker.isHidden = true
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
    
    //next
    @objc func rightSwipe() {
        for (ind, book) in biblia.enumerated() where abbrev == book.abbrev["pt"] {
            if chapter <  (book.chapters ?? 0) - 1 {
                chapter += 1
                return
            } else if ind < (biblia.count - 1) {
                self.chapter = 0
                abbrev = allLivros[ind + 1].abbrev
                livroAtual = getLivroAtual(abreviacao: abbrev)
                return
            }
        }
    }
    
    //voltar
    @objc func leftSwipe() {
        for (ind, book) in biblia.enumerated() where abbrev == book.abbrev["pt"] {
            if chapter > 0 {
                chapter -= 1
                return
            } else if ind > 0 {
                abbrev = allLivros[ind - 1].abbrev
                livroAtual = getLivroAtual(abreviacao: abbrev)
                chapter = (livroAtual?.chapters.count ?? 0) - 1
                return
            }
        }
    }
    
    @objc func showPicker() {
        picker.isHidden = false
    }
    func dmissPicker() {
        picker.isHidden = true
    }
    
    // MARK: Helpers
    
    private func configureUI() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .backgroundColor
        navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = .backgroundColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: versionButton)
    }
    private func setupPicker() {
        
        picker.delegate = self
        picker.dataSource = self
        view.insertSubview(picker, at: 1)
        picker.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
    }
    
    func getLivroAtual(abreviacao: String) -> Livro? {
        allLivros.filter {$0.abbrev == abreviacao}.first ?? nil
    }
    private func setupSwipeGestures() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        view.addGestureRecognizer(rightSwipe)
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
    }
    
    private func setupDefaultsValues() {
        if defaults.object(forKey: "abbr") != nil { } else {
            defaults.set("gn", forKey: "abbr")
        }
        
        if defaults.object(forKey: "version") != nil { } else {
            defaults.set(NVI, forKey: "version")
        }
        
        if defaults.object(forKey: "chapter") != nil { } else {
            defaults.set(0, forKey: "chapter")
        }
        
    }
    
    private func getDefaultChapter() -> Int {
        defaults.integer(forKey: "chapter")
    }
    private func getDefaultAbbrev() -> String {
        defaults.string(forKey: "abbr") ?? "gn"
    }
    private func getDefaultVersion() -> String {
        defaults.string(forKey: "version") ?? NVI
    }
    
    private func updateDefaultValues() {
        defaults.set(abbrev, forKey: "abbr")
        defaults.set(chapter, forKey: "chapter")
        defaults.set(version, forKey: "version")
    }
    
    private func showHiddenArrowsLeftRight() {
        if livroAtual?.abbrev == "gn" && chapter == 0 {
            leftSwipeButton.isEnabled = false } else {
            leftSwipeButton.isEnabled = true
        }
        
        if livroAtual?.abbrev == "ap" && chapter == 21 {
            rightSwipeButton.isEnabled = false} else {
            rightSwipeButton.isEnabled = true
        }
    }
    
    private func updateButtonTitle() {
        let buttonTitle = "\(livroAtual?.name ?? "")"  + " " + "\((self.chapter ) + 1)"
        titleButton.setTitle(buttonTitle, for: .normal)
        let versionButtonTitle = version.uppercased()
        versionButton.setTitle(versionButtonTitle, for: .normal)
    }
    
    private func setupTableView() {
        view.insertSubview(tableView, at: 0)
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
        
        if chapter < livroAtual?.chapters.count ?? 0 {
            return livroAtual?.chapters[chapter].count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let myCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as?
            BibliaTableViewCell else { return UITableViewCell() }
        
        let num = "\(indexPath.row + 1)"
        let verso =  "\(livroAtual?.chapters[chapter ][indexPath.row] ?? "")"
        
        myCell.createCell(num: num, verso: verso)
        return myCell
    }
}

extension BibliaViewController: LivrosTableViewDelegate {
    func didSelectSection(abbr: String, chapter: Int) {
        self.chapter = chapter
        self.abbrev = abbr
        livroAtual = getLivroAtual(abreviacao: abbr)
    }
}
