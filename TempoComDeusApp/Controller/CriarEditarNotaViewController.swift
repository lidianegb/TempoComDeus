//
//  CrieateAndEditNoteViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 15/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
// swiftlint:disable type_body_length
import UIKit
enum Action {
    case edit, create
}
class CrieateAndEditNoteViewController: UIViewController, UITextViewDelegate {
    // MARK: Properties
    let backView = BackView()
    private let noteRepository: NoteRepository
    private let noteID: UUID
    private let action: Action
    var stackViewBottom: UIStackView!
    private var note: Note {
        didSet {
            backView.backgroundColor = .getColor(name: note.color)
            textView.text = note.body
        }
    }
    var color: String {
        didSet {
            switch action {
            case .create: break
            case .edit:
                self.saveButton.isEnabled = !(self.textView.text == note.body && color == note.color)
            }
        }
    }
    weak var delegate: NewNoteDelegate?
    var onDidChange:((_ body: String, _ color: String, _ noteId: UUID) -> Void)?
    
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
    init(noteRepository: NoteRepository, noteId: UUID, action: Action) {
        self.noteRepository = noteRepository
        self.noteID = noteId
        self.action = action
        self.note = noteRepository.readItem(itemId: noteId) ?? Note(body: nil, color: "nota1", versos: [])
        self.color = note.color
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("We aren't using storyboards")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addStackHeader()
        addStackBottom()
        addBackView()
        addTextView()
       
        setFonteSize()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardHiden),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.textView.becomeFirstResponder()
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
        textView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        textView.text = note.body
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
        let buttonColor1 = createButtonCor(cor: "nota1")
        buttonColor1.addTarget(self, action: #selector(changeColor1), for: .touchUpInside)
        
        let buttonColor2 = createButtonCor(cor: "nota2")
        buttonColor2.addTarget(self, action: #selector(changeColor2), for: .touchUpInside)
        
        let buttonColor3 = createButtonCor(cor: "nota3")
        buttonColor3.addTarget(self, action: #selector(changeColor3), for: .touchUpInside)
        
        let buttonColor4 = createButtonCor(cor: "nota4")
        buttonColor4.addTarget(self, action: #selector(changeColor4), for: .touchUpInside)
        
        let buttonColor5 = createButtonCor(cor: "nota5")
        buttonColor5.addTarget(self, action: #selector(changeColor5), for: .touchUpInside)
        
         stackViewBottom = UIStackView(arrangedSubviews:
                                            [buttonColor1,
                                             buttonColor2,
                                             buttonColor3,
                                             buttonColor4,
                                             buttonColor5,
                                             UIView()])
        stackViewBottom.alignment = .leading
        stackViewBottom.spacing = 10
      
        view.addSubview(stackViewBottom)
        stackViewBottom.anchor(
                               left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
                               right: view.rightAnchor,
                               
                               paddingLeft: 16,
                               paddingBottom: 16,
                               paddingRight: 16)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == self.textView {
            switch action {
            case .create:
                self.saveButton.isEnabled = !textView.text.isEmpty
            case .edit:
                self.saveButton.isEnabled = !(self.textView.text == note.body && color == note.color)
            }
        }
    }
    
    // MARK: Selectors
    
    @objc func tapDone(sender: UITextView) {
        textView.resignFirstResponder()
    }
    
    @objc func cancelar() {
        switch action {
        case .create:
            if let text = textView.text, text.isEmpty {
                self.dismiss(animated: true, completion: nil) } else {
                    displayActionSheet()
                }
        case .edit:
            if  textView.text == note.body {
                if color == note.color {
                    self.dismiss(animated: true, completion: nil)
                    return
                }
            }
            displayActionSheet()
        }
    }
    
    @objc func salvar() {
        switch action {
        case .create:
            let newNota = Note(body: textView.text, color: color, versos: [])
            _ = noteRepository.createNewItem(item: newNota)
            delegate?.updateNotas(notes: noteRepository.readAllItems())
            self.dismiss(animated: true, completion: nil)
        case .edit:
            onDidChange?(textView.text, color, noteID)
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
        
        menu.view.subviews.flatMap({$0.constraints}).filter { (one: NSLayoutConstraint) -> (Bool)  in
        return (one.constant < 0) && (one.secondItem == nil) &&  (one.firstAttribute == .width)
        }.first?.isActive = false
    }
    
    @objc func changeColor1() {
        backView.backgroundColor = .noteColor1
        color = "nota1"
    }
    @objc func changeColor2() {
        backView.backgroundColor = .noteColor2
        color = "nota2"
    }
    @objc func changeColor3() {
        backView.backgroundColor = .noteColor3
        color = "nota3"
    }
    @objc func changeColor4() {
        backView.backgroundColor = .noteColor4
        color = "nota4"
    }
    @objc func changeColor5() {
        backView.backgroundColor = .noteColor5
        color = "nota5"
    }
    
    @objc func keyboardHiden(notification: NSNotification) {
        if let duration =  notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            UIView.animate(withDuration: duration) {
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
        view.addSubview(backView)
        backView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        left: view.leftAnchor,
                        bottom: stackViewBottom.topAnchor,
                        right: view.rightAnchor,
                        paddingTop: 40,
                        paddingLeft: 8,
                        paddingBottom: 16,
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
