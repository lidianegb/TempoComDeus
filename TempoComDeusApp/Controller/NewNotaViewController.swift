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
            saveButton.isEnabled = !(nota?.body.isEmpty ?? true)
        }
    }
    
    lazy var adicionarVersiculo: UILabel  = {
        let field = UILabel()
        field.text = "  Adicionar versículo"
        field.textColor = .secondaryLabel
        field.backgroundColor = .backViewColor
        field.textAlignment = .left
        field.font = UIFont.systemFont(ofSize: 17)
        field.layer.cornerRadius = 8
        field.clipsToBounds = true
        return field
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .backgroundColor
        tableView.layer.cornerRadius = 20
        tableView.layer.masksToBounds = true
        tableView.tableFooterView = nil
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: CGFloat.leastNormalMagnitude))
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
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
        addStackHeader()
        addVersiculo()
        setupTableView()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
               
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardHiden),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
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
        view.addSubview(tableView)
        tableView.anchor(top: adicionarVersiculo.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 8,
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
                               left: view.leftAnchor,
                               right: view.rightAnchor,
                               paddingTop: 0,
                               paddingLeft: 16,
                               paddingRight: 16)
    }
    
    func addVersiculo() {
        view.addSubview(adicionarVersiculo)
        adicionarVersiculo.anchor(top: cancelButton.bottomAnchor,
                                  left: view.leftAnchor,
                                  right: view.rightAnchor,
                                  paddingTop: 8,
                                  paddingLeft: 8,
                                  paddingRight: 8, height: 40)
    }
    
    @objc func keyboardHiden(notification: NSNotification) {
            if let duracao =  notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
                UIView.animate(withDuration: duracao) {
                    self.view.frame = UIScreen.main.bounds
                    self.view.layoutIfNeeded()
                }
            }
        }

    @objc func keyboardShow(notification: NSNotification) {
         if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?
            NSValue)?.cgRectValue {
             if let duracao = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
                 
                 UIView.animate(withDuration: duracao) {
                     self.view.frame = CGRect(
                         x: UIScreen.main.bounds.origin.x,
                         y: UIScreen.main.bounds.origin.y,
                         width: UIScreen.main.bounds.width,
                         height: UIScreen.main.bounds.height - keyboardSize.height
                     )
                     self.view.layoutIfNeeded()
                 }
             }
         }
     }
    
}
extension NewNotaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return  0
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
        cell.textView.sizeToFit()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension

    }
    
}
extension NewNotaViewController: NewNotaDelegate {
    func updateHeightOfRow(_ cell: NotaTableViewCell, _ textView: UITextView) {
        let size = textView.bounds.size
        let newSize = tableView.sizeThatFits(CGSize(width: size.width,
                                                    height: CGFloat.greatestFiniteMagnitude))
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            tableView.beginUpdates()
            tableView.endUpdates()
            UIView.setAnimationsEnabled(true)
            if let thisIndexPath = tableView.indexPath(for: cell) {
                tableView.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
            }
        }
    }

    func getVersos(versos: [Verso]) {
        self.nota?.versos = versos
    }
  
    func getNota(nota: Nota) {
        self.nota = nota
    }
}
