//
//  NewNotaViewController.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 17/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

enum Acao {
    case editar, criar
}

class NewNotaViewController: UIViewController {
    
    let sectionOne = "sectionOne"
    let sectionTwo = "sectionTwo"
    private let notaRepository: NotaRepository
    private let notaID: UUID
    private let acao: Acao
    weak var delegate: NovaNotaDelegate?
    
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
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancelar", for: .normal)
        button.setTitleColor(.blueAct, for: .normal)
        button.addTarget(self, action: #selector(cancelar), for: .touchUpInside)
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Salvar", for: .normal)
        button.setTitleColor(.blueAct, for: .normal)
      //  button.setTitle("", for: .disabled)
      //  button.isEnabled = false
        button.addTarget(self, action: #selector(salvar), for: .touchUpInside)
        return button
    }()
    
    init(notaRepository: NotaRepository, notaId: UUID, acao: Acao) {
        self.notaRepository = notaRepository
        self.notaID = notaId
        self.acao = acao
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupTableView()
        addStackHeader()
        // Do any additional setup after loading the view.
    }
    
    @objc func salvar() {
        switch acao {
        case .criar:
            delegate?.updateNotas(notas: notaRepository.readAllItems())
            self.dismiss(animated: true, completion: nil)
        case .editar:
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func cancelar() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    private func configureUI() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .backgroundColor
        navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = .backgroundColor
    }
    
    func setupTableView() {
        view.insertSubview(tableView, at: 0)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 8,
                         paddingBottom: 0,
                         paddingRight: 8)
        tableView.register(VersiculoTableViewCell.self, forCellReuseIdentifier: sectionOne)
        tableView.register(NotaTableViewCell.self, forCellReuseIdentifier: sectionTwo)
    }
    
    func addStackHeader() {
        let stackViewHeader = UIStackView(arrangedSubviews: [cancelButton, saveButton])
        stackViewHeader.distribution = .equalSpacing
        view.addSubview(stackViewHeader)
        stackViewHeader.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                               left: tableView.leftAnchor,
                               right: tableView.rightAnchor,
                               paddingTop: 0,
                               paddingLeft: 8,
                               paddingRight: 8)
    }
    
}
extension NewNotaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: sectionOne, for: indexPath)
                    as? VersiculoTableViewCell else { return UITableViewCell() }
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: sectionTwo, for: indexPath)
                as? NotaTableViewCell else { return UITableViewCell() }
        return cell
    }
    
}
