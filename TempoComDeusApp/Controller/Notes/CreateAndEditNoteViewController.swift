//
//  CreateAndEditNoteViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 15/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.

import UIKit
class CreateAndEditNoteViewController: UIViewController, UITextViewDelegate {
    
    // MARK: Properties
    private let noteRepository: NoteRepository
    private let noteID: UUID
    private let action: Action
    private var stackViewHeader: UIStackView!
    private var stackViewBottom: UIStackView!
    var onUpdateNotes: (() -> Void)?

    private var note: Note {
        didSet {
            textView.text = note.body
            textView.backgroundColor = .getColor(number: note.color)
        }
    }
    
    private var color: Int {
        didSet {
            switch action {
            case .create: break
            case .edit:
                self.saveButton.isEnabled = !(self.textView.text == note.body && color == note.color)
            }
        }
    }
    
    private var textView: UITextView = {
        let text = UITextView()
        text.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        text.isEditable = true
        text.textAlignment = .left
        text.font = UIFont.systemFont(ofSize: 20)
        text.textColor = .label
        text.layer.cornerRadius = 8
        text.clipsToBounds = true
        text.textContainerInset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
        return text
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancelar", for: .normal)
        button.setTitleColor(.blueAct, for: .normal)
        button.addTarget(self, action: #selector(cancelar), for: .touchUpInside)
        return button
    }()
    
    private let saveButton: UIButton = {
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
        self.note = noteRepository.readItem(itemId: noteId) ?? Note(body: nil, color: 1)
        self.color = note.color
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("We aren't using storyboards")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
    
    // MARK: Selectors
    
    @objc func tapDone(sender: UITextView) {
        textView.resignFirstResponder()
    }
    
    @objc func cancelar() {
        switch action {
        case .create:
            if let text = textView.text, text.isEmpty {
                self.dismiss(animated: true, completion: nil)
            } else { displayActionSheet() }
        case .edit:
            if  textView.text == note.body && color == note.color {
                    self.dismiss(animated: true, completion: nil)
            } else { displayActionSheet() }
        }
    }
    
    @objc func salvar() {
        note.body = textView.text
        note.color = color
        noteRepository.update(item: note)
        onUpdateNotes?()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func changeColor(_ sender: UIButton) {
        guard let noteColor = sender.backgroundColor else { return }
        textView.backgroundColor = noteColor
        self.color = MyColors.getColorNumber(color: noteColor.cgColor)
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
        
        addStackHeader()
        addStackBottom()
        addTextView()
        setFonteSize()
    }
    
    private func createButtonCor(cor: Int) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .getColor(number: cor)
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
    
    func addStackHeader() {
        stackViewHeader = UIStackView(arrangedSubviews: [cancelButton, saveButton])
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
        textView.backgroundColor = .getColor(number: note.color)
        textView.delegate = self
        view.addSubview(textView)
        textView.anchor(top: stackViewHeader.bottomAnchor,
                        left: view.leftAnchor,
                        bottom: stackViewBottom.topAnchor,
                        right: view.rightAnchor,
                        paddingTop: 8,
                        paddingLeft: 8,
                        paddingBottom: 8,
                        paddingRight: 8)
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
        var arrangedButtons: [UIButton] = []
        for number in 1...5 {
            let buttonColor = createButtonCor(cor: number)
            buttonColor.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
            arrangedButtons.append(buttonColor)
        }
        arrangedButtons.append(UIButton())
        stackViewBottom = UIStackView(arrangedSubviews: arrangedButtons)
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
    
    func displayActionSheet() {
        let menu = UIAlertController(title: nil, message: "Descartar alterações?", preferredStyle: .actionSheet)
        let deleteAtion = UIAlertAction(title: "Descartar", style: .destructive, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        menu.addAction(deleteAtion)
        menu.addAction(cancelAction)
        self.present(menu, animated: true, completion: nil)
        
        menu.view.subviews.flatMap({$0.constraints}).filter { (one: NSLayoutConstraint) -> (Bool)  in
        return (one.constant < 0) && (one.secondItem == nil) &&  (one.firstAttribute == .width)
        }.first?.isActive = false
    }
}