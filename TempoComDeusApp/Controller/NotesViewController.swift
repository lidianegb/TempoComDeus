//
//  NotesViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {

    // MARK: Properties
    
    let cellId = "CellId"
    let backView = BackView()
    var fonteSize: Int? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
                       
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.layer.cornerRadius = 8
        collectionView.layer.masksToBounds = true
        collectionView.backgroundColor = .backViewColor
        collectionView.alwaysBounceVertical = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    var noteRepository: NoteRepository {
          NoteRepository()
    }
    
    var notes: [Note] = [] {
         didSet {
             if notes.isEmpty {
                initialLabel.isHidden = false
                collectionView.isHidden = true
             } else {
                collectionView.isHidden = false
                initialLabel.isHidden = true
            }
            collectionView.reloadData()
         }
     }
     
    let initialLabel: UILabel = {
        var label = UILabel()
        label.text = "Clique + para adicionar uma nova nota."
        label.textColor = .placeholderText
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    let titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Anotações"
        label.textColor = .label
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
   
      // MARK: Lifecycle
      override func viewDidLoad() {
        super.viewDidLoad()
        notes = noteRepository.readAllItems()
        fonteSize = UserDefaults.standard.integer(forKey: FONTSIZE)
        configureUI()
        addBackground()
        addTextInicial()
        setupCollectionView()
      }
    
    override func viewWillAppear(_ animated: Bool) {
        fonteSize = UserDefaults.standard.integer(forKey: FONTSIZE)
    }
      
      // MARK: Selectors

    @objc func createNewNota() {
        let novaNotaViewController = CrieateAndEditNoteViewController(noteRepository: noteRepository,
                                                                      noteId: UUID(),
                                                                      action: .create)
        novaNotaViewController.modalPresentationStyle = .fullScreen
        novaNotaViewController.delegate = self
        self.present(novaNotaViewController, animated: true)
    }
       // MARK: Helpers
    
    func configureUI() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = .backgroundColor
        backView.backgroundColor = .backViewColor
        navigationItem.titleView = titleLabel
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(createNewNota))
    
    }

    func addTextInicial() {
        backView.addSubview(initialLabel)
        initialLabel.anchor(left: backView.leftAnchor,
                            right: backView.rightAnchor,
                            paddingLeft: 16,
                            paddingRight: 16)
        initialLabel.centerY(inView: backView)
    }
    
    func addBackground() {
        view.addSubview(backView)
        backView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          right: view.rightAnchor,
                          paddingTop: 0,
                          paddingLeft: 8,
                          paddingBottom: 0,
                          paddingRight: 8)
      }
    
    func setupCollectionView() {
       collectionView.register(NotesCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
       collectionView.delegate = self
       collectionView.dataSource = self
       view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              left: view.leftAnchor,
                              bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              right: view.rightAnchor,
                              paddingTop: 0,
                              paddingLeft: 8,
                              paddingBottom: 0,
                              paddingRight: 8)
        
       }
    
    func displayActionSheet(cell: NotesCollectionViewCell) {
            let menu = UIAlertController(title: nil, message: "Deletar nota?", preferredStyle: .actionSheet)
            let deleteAtion = UIAlertAction(title: "Deletar", style: .destructive, handler: { _ in
                self.deleteCell(cell: cell)
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
    
    func deleteCell(cell: NotesCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            collectionView.performBatchUpdates({
                _ = noteRepository.delete(itemId: notes[indexPath.row].notaId)
                collectionView.deleteItems(at: [indexPath])
                notes = noteRepository.readAllItems()
            }, completion: nil)
        }
    }
    
    func notaIsUpdated(updated: Bool) {
        if updated {
            notes = noteRepository.readAllItems()
        }
    }
}

extension NotesViewController: NewNoteDelegate {
    func updateNotas(notes: [Note]) {
        self.notes = notes
    }
}
