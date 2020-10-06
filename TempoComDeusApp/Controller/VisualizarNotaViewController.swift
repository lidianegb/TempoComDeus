//
//  VisualizarNotaViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 14/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class VisualizarNotaViewController: UIViewController {
    // MARK: Properties
    
    weak var delegate: UpdateNotaDelegate?
    var stackButtons: UIStackView!
    var backView = BackView()
    var color: String
    private let notaRepository: NotaRepository
    private let notaID: UUID
    private var nota: Nota {
        didSet {
            textView.text = nota.body
            textView.backgroundColor = .getColor(name: nota.cor)
        }
    }
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Salvar", for: .normal)
        button.setTitleColor(.blueAct, for: .normal)
        button.addTarget(self, action: #selector(salvar), for: .touchUpInside)
        return button
    }()
    
    lazy var textView: UITextView = {
        let text = UITextView()
        text.isEditable = false
        text.isSelectable = false
        text.textAlignment = .left
        text.showsVerticalScrollIndicator = true
        text.textColor = .label
        text.layer.cornerRadius = 20
        text.layer.masksToBounds = true
        text.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        text.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        text.font = UIFont.systemFont(ofSize: 20)
        return text
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.tintColor = .blueAct
        button.addTarget(self, action: #selector(editNota), for: .touchUpInside)
        return button
    }()
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.tintColor = .blueAct
        button.addTarget(self, action: #selector(shareNota), for: .touchUpInside)
        return button
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addBackView()
        addTextView()
        addStackViewButtons()
        setFonteSize()
        saveButton.isHidden = true
        addStackBottom()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardHiden),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    init(notaRepository: NotaRepository, notaId: UUID) {
        self.notaRepository = notaRepository
        self.notaID = notaId
        self.nota = notaRepository.readItem(itemId: notaID) ?? Nota(body: nil, cor: nil, versos: [])
        self.color = nota.cor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("We aren't using storyboards")
    }
    
    // MARK: Selectors
    @objc  func editNota() {
        saveButton.isHidden = false
        shareButton.isHidden = true
        editButton.isHidden = true
        textView.isEditable = true
        textView.isSelectable = true
        textView.becomeFirstResponder()
    }
    @objc func shareNota() {
        let viewActivity = UIActivityViewController(activityItems: [nota.body], applicationActivities: [])
        self.present(viewActivity, animated: true)
    }
    
    @objc func salvar() {
        didChange(body: textView.text, cor: color, notaId: notaID)
        saveButton.isHidden = true
        textView.isEditable = false
        textView.isSelectable = false
        shareButton.isHidden = false
        editButton.isHidden = false
    }
    
    @objc func tapDone(sender: UITextView) {
        textView.resignFirstResponder()
    }
    
    @objc func changeColor1() {
        textView.backgroundColor = .nota1
        color = "nota1"
    }
    @objc func changeColor2() {
        textView.backgroundColor = .nota2
        color = "nota2"
    }
    @objc func changeColor3() {
        textView.backgroundColor = .nota3
        color = "nota3"
    }
    @objc func changeColor4() {
        textView.backgroundColor = .nota4
        color = "nota4"
    }
    @objc func changeColor5() {
        textView.backgroundColor = .nota5
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
    
    func configureUI() {
        navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = .backgroundColor
    }
    
    private func addBackView() {
        backView.backgroundColor = .backgroundColor
        view.addSubview(backView)
        backView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        left: view.leftAnchor,
                        bottom: view.safeAreaLayoutGuide.bottomAnchor,
                        right: view.rightAnchor)
    }
    
    private func addStackViewButtons() {
        stackButtons = UIStackView(arrangedSubviews: [editButton, shareButton, saveButton])
        stackButtons.distribution = .equalSpacing
        stackButtons.spacing = 20
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: stackButtons)
    }
    
    func addTextView() {
        textView.text = nota.body
        textView.backgroundColor = .getColor(name: nota.cor)
        
        backView.addSubview(textView)
        textView.anchor(top: backView.topAnchor,
                        left: backView.leftAnchor,
                        right: backView.rightAnchor)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
    
    func didChange(body: String, cor: String, notaId: UUID) {
        nota.body = body
        nota.cor = cor
        notaRepository.update(item: nota)
        nota = notaRepository.readItem(itemId: notaId) ?? Nota(body: nil, cor: nil, versos: [])
        self.delegate?.notaIsUpdated(updated: true)
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
                                            [cor1, cor2, cor3, cor4, cor5,
                                             UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))])
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
    
    private func createButtonCor(cor: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .getColor(name: cor)
        button.layer.borderWidth = 0.3
        button.layer.borderColor = UIColor.black.cgColor
        button.setDimensions(width: 32, height: 32)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        return button
    }
    
}
