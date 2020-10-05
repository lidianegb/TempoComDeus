//
//  CriarEditarNotaViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 15/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//swiftlint:disable type_body_length
import UIKit

class CriarEditarNota: UIViewController, UITextViewDelegate {
    // MARK: Properties
    let backView = BackView()
    private let notaRepository: NotaRepository
    private let notaID: UUID
    private let acao: Acao
    
    private var nota: Nota {
        didSet {
            backView.backgroundColor = .getColor(name: nota.cor)
            textView.text = nota.body
        }
    }
    var color: String {
        didSet {
            switch acao {
            case .criar: break
            case .editar:
                self.saveButton.isEnabled = !(self.textView.text == nota.body && color == nota.cor)
            }
        }
    }
    weak var delegate: NovaNotaDelegate?
    weak var notadelegate: NotaDelegate?
    
    var textView: UITextView = {
        let text = UITextView()
        text.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        text.isEditable = true
        text.textAlignment = .left
        text.backgroundColor = .clear
        text.font = UIFont.systemFont(ofSize: 20)
        text.textColor = .label
        return text
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
    
    // MARK: Lifecycle
    init(notaRepository: NotaRepository, notaId: UUID, acao: Acao) {
        self.notaRepository = notaRepository
        self.notaID = notaId
        self.acao = acao
        self.nota = notaRepository.readItem(itemId: notaId) ?? Nota(body: nil, cor: "nota1", versos: [])
        self.color = nota.cor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("We aren't using storyboards")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addBackView()
        addStackHeader()
        addTextView()
        addStackBottom()
        setFonteSize()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardHiden),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func addStackHeader() {
        let stackViewHeader = UIStackView(arrangedSubviews: [cancelButton, saveButton])
        stackViewHeader.distribution = .equalSpacing
        view.addSubview(stackViewHeader)
        stackViewHeader.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                               left: view.leftAnchor,
                               right: view.rightAnchor,
                               paddingTop: 0,
                               paddingLeft: 8,
                               paddingRight: 8)
    }
    
    func addTextView() {
        textView.text = nota.body
        textView.delegate = self
        backView.addSubview(textView)
        textView.anchor(top: backView.topAnchor,
                        left: backView.leftAnchor,
                        bottom: backView.bottomAnchor,
                        right: backView.rightAnchor,
                        paddingTop: 20,
                        paddingLeft: 16,
                        paddingBottom: 80,
                        paddingRight: 16)
    }
    
    func setFonteSize() {
        if UserDefaults.standard.object(forKey: FONTSIZE) != nil {} else {
            UserDefaults.standard.set(17, forKey: FONTSIZE)
        }
        let fonteSize: Int? = UserDefaults.standard.integer(forKey: FONTSIZE)
        if let fonteSize = fonteSize {
            textView.font = UIFont.systemFont(ofSize: CGFloat(fonteSize))
        }
    }
    
    func addStackBottom() {
        let cor1 = createButtonCor(cor: "nota1")
        cor1.addTarget(self, action: #selector(changeColor1), for: .touchUpInside)
        
        let cor2 = createButtonCor(cor: "nota2")
        cor2.addTarget(self, action: #selector(changeColor2), for: .touchUpInside)
        
        let cor3 = createButtonCor(cor: "nota3")
        cor3.addTarget(self, action: #selector(changeColor3), for: .touchUpInside)
        
        let cor4 = createButtonCor(cor: "nota4")
        cor4.addTarget(self, action: #selector(changeColor4), for: .touchUpInside)
        
        let cor5 = createButtonCor(cor: "nota5")
        cor5.addTarget(self, action: #selector(changeColor5), for: .touchUpInside)
        
        let stackViewBottom = UIStackView(arrangedSubviews:
                                            [cor1, cor2, cor3, cor4, cor5, UIView(), UIView(), UIView()])
        stackViewBottom.alignment = .leading
        stackViewBottom.spacing = 10
        
        backView.addSubview(stackViewBottom)
        stackViewBottom.anchor(top: textView.bottomAnchor,
                               left: backView.leftAnchor,
                               bottom: backView.bottomAnchor,
                               right: backView.rightAnchor,
                               paddingTop: 20,
                               paddingLeft: 16,
                               paddingBottom: 10,
                               paddingRight: 16)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == self.textView {
            switch acao {
            case .criar:
                self.saveButton.isEnabled = !textView.text.isEmpty
            case .editar:
                self.saveButton.isEnabled = !(self.textView.text == nota.body && color == nota.cor)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: Selectors
    
    @objc func tapDone(sender: Any) {
        view.endEditing(true)
    }
    
    @objc func cancelar() {
        switch acao {
        case .criar:
            if let text = textView.text, text.isEmpty {
                self.dismiss(animated: true, completion: nil) } else {
                    displayActionSheet()
                }
        case .editar:
            if  textView.text == nota.body {
                if color == nota.cor {
                    self.dismiss(animated: true, completion: nil)
                    return
                }
            }
            displayActionSheet()
        }
    }
    
    @objc func salvar() {
        switch acao {
        case .criar:
            let newNota = Nota(body: textView.text, cor: color, versos: [])
            _ = notaRepository.createNewItem(item: newNota)
            delegate?.updateNotas(notas: notaRepository.readAllItems())
            self.dismiss(animated: true, completion: nil)
        case .editar:
            notadelegate?.didChange(body: textView.text, cor: color, notaId: notaID)
            self.dismiss(animated: true, completion: nil)
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
    
    @objc func changeColor1() {
        backView.backgroundColor = .nota1
        color = "nota1"
    }
    @objc func changeColor2() {
        backView.backgroundColor = .nota2
        color = "nota2"
    }
    @objc func changeColor3() {
        backView.backgroundColor = .nota3
        color = "nota3"
    }
    @objc func changeColor4() {
        backView.backgroundColor = .nota4
        color = "nota4"
    }
    @objc func changeColor5() {
        backView.backgroundColor = .nota5
        color = "nota5"
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
    
    // MARK: Helpers
    
    private func configureUI() {
        navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = .backgroundColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
    }
    
    private func addBackView() {
        backView.backgroundColor = .getColor(name: color)
        view.insertSubview(backView, at: 0)
        backView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        left: view.leftAnchor,
                        bottom: view.safeAreaLayoutGuide.bottomAnchor,
                        right: view.rightAnchor,
                        paddingTop: 40,
                        paddingLeft: 8,
                        paddingBottom: 0,
                        paddingRight: 8)
    }
    
    private func createButtonCor(cor: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .getColor(name: cor)
        button.layer.borderWidth = 0.3
        button.layer.borderColor = UIColor.black.cgColor
        button.setDimensions(width: 32, height: 32)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        addShadowing(view: button)
        return button
    }
    
    func addShadowing(view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 2.0
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}
