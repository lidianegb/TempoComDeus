//
//  ViewNoteViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 14/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class ViewNoteViewController: UIViewController {
    // MARK: Properties
    
    weak var delegate: UpdateNoteDelegate?
    var stackTopButtons: UIStackView!
    var backView = BackView()
    var color: String
    private let noteRepository: NoteRepository
    private let noteID: UUID
    private var note: Note {
        didSet {
            textView.text = note.body
            textView.backgroundColor = .getColor(name: note.color)
        }
    }
    
    lazy var textView: UITextView = {
        let text = UITextView()
        text.isEditable = false
        text.isSelectable = false
        text.textAlignment = .left
        text.showsVerticalScrollIndicator = true
        text.textColor = .label
        text.layer.cornerRadius = 20
        text.layer.masksToBounds = true
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
        addStackViewButtons()
        addTextView()
        setFonteSize()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardHiden),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    init(notaRepository: NoteRepository, notaId: UUID) {
        self.noteRepository = notaRepository
        self.noteID = notaId
        self.note = notaRepository.readItem(itemId: noteID) ?? Note(body: nil, color: nil, versos: [])
        self.color = note.color
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("We aren't using storyboards")
    }
    
    // MARK: Selectors
    @objc  func editNota() {
        let editNoteViewController = CrieateAndEditNoteViewController(noteRepository: noteRepository,
                                                                      noteId: noteID,
                                                                      action: .edit)
        editNoteViewController.notedelegate = self
        editNoteViewController.modalPresentationStyle = .fullScreen
        editNoteViewController.modalTransitionStyle = .crossDissolve
        self.present(editNoteViewController, animated: true)
    }
    
    @objc func shareNota() {
        let viewActivity = UIActivityViewController(activityItems: [note.body], applicationActivities: [])
        self.present(viewActivity, animated: true)
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
        stackTopButtons = UIStackView(arrangedSubviews: [editButton, shareButton])
        stackTopButtons.distribution = .equalSpacing
        stackTopButtons.spacing = 20
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: stackTopButtons)
    }
    
    func addTextView() {
        textView.text = note.body
        textView.backgroundColor = .getColor(name: note.color)
        
        backView.addSubview(textView)
        textView.anchor(top: backView.topAnchor,
                        left: backView.leftAnchor,
                        bottom: backView.bottomAnchor,
                        right: backView.rightAnchor)
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
}

extension ViewNoteViewController: NoteDelegate {
    func didChange(body: String, color: String, noteId: UUID) {
        note.body = body
        note.color = color
        noteRepository.update(item: note)
        note = noteRepository.readItem(itemId: noteId) ?? Note(body: nil, color: nil, versos: [])
        self.delegate?.notaIsUpdated(updated: true)
    }
    
}
