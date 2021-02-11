//
//  ViewNoteViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 14/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.

import UIKit
import CoreData
class ViewNoteViewController: UIViewController {
    // MARK: Properties
    var service: CoreDataService!
    var noteIsUpdated: (() -> Void)?
    var stackTopButtons: UIStackView!
    var color: Int
    private var noteViewModel: NoteViewModel {
        didSet {
            textView.text = noteViewModel.text
            textView.backgroundColor = .getColor(number: Int(noteViewModel.color))
        }
    }
    
    lazy var textView: UITextView = {
        let text = UITextView()
        text.isEditable = false
        text.isSelectable = false
        text.textAlignment = .left
        text.showsVerticalScrollIndicator = true
        text.textColor = .label
        text.layer.cornerRadius = 8
        text.layer.masksToBounds = true
        text.textContainerInset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
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
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Voltar", for: .normal)
        button.setTitleColor(.blueAct, for: .normal)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
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
    }
    
    init(service: CoreDataService, noteViewModel: NoteViewModel) {
        self.service = service
        self.noteViewModel = noteViewModel
        self.color = Int(noteViewModel.color)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("We aren't using storyboards")
    }
    
    // MARK: Selectors
    @objc  func editNota() {
        let editNoteViewController =
            CreateAndEditNoteViewController(service: nil, noteViewModel: noteViewModel, action: .edit)
        editNoteViewController.onUpdateNotes = {
            self.didChange(noteId: self.noteViewModel.noteId)
        }
        
        editNoteViewController.modalPresentationStyle = .fullScreen
        editNoteViewController.modalTransitionStyle = .crossDissolve
        self.present(editNoteViewController, animated: true)
    }
    
    @objc func shareNota() {
        let viewActivity = UIActivityViewController(activityItems: [noteViewModel.text], applicationActivities: [])
        self.present(viewActivity, animated: true)
    }
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Helpers
    
    func configureUI() {
        view.backgroundColor = .backgroundColor
        addStackViewButtons()
        addTextView()
        setFonteSize()
    }

    private func addStackViewButtons() {
        let stackButtons = UIStackView(arrangedSubviews: [editButton, shareButton])
        stackButtons.distribution = .equalSpacing
        stackButtons.spacing = 20
        stackTopButtons = UIStackView(arrangedSubviews: [backButton, stackButtons])
        stackTopButtons.distribution = .equalSpacing
        view.addSubview(stackTopButtons)
        stackTopButtons.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                               left: view.leftAnchor,
                               right: view.rightAnchor,
                               paddingTop: 0,
                               paddingLeft: 8,
                               paddingRight: 8)
    }
    
    func addTextView() {
        textView.text = noteViewModel.text
        textView.backgroundColor = .getColor(number: Int(noteViewModel.color))
        
        view.addSubview(textView)
        textView.anchor(top: stackTopButtons.bottomAnchor,
                        left: view.leftAnchor,
                        bottom: view.safeAreaLayoutGuide.bottomAnchor,
                        right: view.rightAnchor,
                        paddingTop: 20,
                        paddingLeft: 8,
                        paddingBottom: 0,
                        paddingRight: 8)
    }
    
    func setFonteSize() {
        let fontSize = UserDefaultsPersistence.shared.getDefaultFontSize()
        textView.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
    }
    
    func didChange(noteId: UUID) {
        noteViewModel = NoteViewModel(service: service, noteId: noteId)
        noteIsUpdated?()
    }
}
