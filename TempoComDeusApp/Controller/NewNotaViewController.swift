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
    private var nota: Nota? {
        didSet {
            saveButton.isEnabled = !(nota?.body.isEmpty ?? true || nota?.versos.isEmpty ?? true)
        }
    }

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
        button.setTitle("", for: .disabled)
        button.isEnabled = false
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
        _ = notaRepository.createNewItem(item: nota ?? Nota(body: nil, cor: nil, versos: []))
        delegate?.updateNotas(notas: notaRepository.readAllItems())
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelar() {
        if let text = nota?.body, text.isEmpty {
            self.dismiss(animated: true, completion: nil) } else {
            displayActionSheet()
        }
    }
    
    @objc func displayActionSheet() {
      let menu = UIAlertController(title: nil, message: "Descartar alterações?", preferredStyle: .actionSheet)
      let deleteAtion = UIAlertAction(title: "Descartar", style: .destructive, handler: { _ in
            self.dismiss(animated: true, completion: nil)
          }
      )
      let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
      menu.addAction(deleteAtion)
      menu.addAction(cancelAction)
      self.present(menu, animated: true, completion: nil)
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
                         paddingBottom: 8,
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
        if section == 0 {
            return nota?.versos.count ?? 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: sectionOne, for: indexPath)
                    as? VersiculoTableViewCell else { return UITableViewCell() }
            cell.createCell()
            cell.delegate = self
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: sectionTwo, for: indexPath)
                as? NotaTableViewCell else { return UITableViewCell() }
        cell.createCell()
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 50
        }
        return tableView.frame.height - 210
    }
    
}
extension NewNotaViewController: NewNotaDelegate {
    func getVersos(versos: [Verso]) {
        self.nota?.versos = versos
    }
    
    func getNota(nota: Nota) {
        self.nota = nota
    }
}
