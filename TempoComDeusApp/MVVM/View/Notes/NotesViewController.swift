//
//  NotesViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.

import UIKit
import CoreData
class NotesViewController: UIViewController {

    // MARK: Properties
    var isPresenting: Bool = true
    let searchController = UISearchController(searchResultsController: nil)
    var context: NSManagedObjectContext!
    var service: CoreDataService!
    var searchActive = false
    var textSearch = ""
    let cellId = "CellId"
    var fonteSize: Int? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
                       
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
    
    var notesViewModel: NotesViewModel! {
        didSet {
            self.updateUI()
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
   
      // MARK: Lifecycle
      override func viewDidLoad() {
        super.viewDidLoad()
        setContext()
        populateData()
        configureUI()
        setupSearchController()
      }
    
    override func viewWillAppear(_ animated: Bool) {
        fonteSize = UserDefaultsPersistence.shared.getDefaultFontSize()
        noteIsUpdated()
        navigationItem.searchController = nil
    }
    
    func animeCell(cell: NotesCollectionViewCell) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn], animations: {
            cell.wrapperView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: { _ in
            cell.wrapperView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
        })
    }
      
      // MARK: Selectors

    @objc func createNewNota() {
        let novaNotaViewController = CreateAndEditNoteViewController(service: service,
                                                                     noteViewModel: nil,
                                                                     action: .create)
        novaNotaViewController.modalPresentationStyle = .fullScreen
        novaNotaViewController.modalTransitionStyle = .crossDissolve
        novaNotaViewController.onUpdateNotes = {
            self.notesViewModel.restartNotes()
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
        self.present(novaNotaViewController, animated: true)
    }
       // MARK: Helpers
    
    func setContext() {
        self.context = (UIApplication.shared.delegate as? AppDelegate)?.persistenceContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        service = CoreDataService(context)
    }
    func populateData() {
        notesViewModel = NotesViewModel(service: service)
        collectionView.reloadData()
    }
    
    func configureUI() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .backgroundColor
        navigationItem.searchController = nil
        navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = .backgroundColor
        navigationItem.title = "Anotações"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(createNewNota))
        setupCollectionView()
        addTextInicial()
    }

    func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Buscar notas"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.isTranslucent = true
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.becomeFirstResponder()
        searchController.searchBar.backgroundColor = .backgroundColor
        self.definesPresentationContext = true
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            if scrollView == self.collectionView {
                navigationItem.searchController = searchController
            }
    }
    
    func addTextInicial() {
        collectionView.addSubview(initialLabel)
        initialLabel.anchor(left: view.leftAnchor,
                            right: view.rightAnchor,
                            paddingLeft: 16,
                            paddingRight: 16)
        initialLabel.centerY(inView: view)
    }
    
    func setupCollectionView() {
       collectionView.register(NotesCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
       collectionView.delegate = self
       collectionView.dataSource = self
       view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              left: view.leftAnchor,
                              bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              right: view.rightAnchor)
       }
    
    func displayActionSheet(cell: NotesCollectionViewCell) {
            let menu = UIAlertController(title: nil, message: "Deletar nota?", preferredStyle: .actionSheet)
            let deleteAtion = UIAlertAction(title: "Deletar", style: .destructive, handler: { _ in
                cell.animationView.play()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
                    self.deleteCell(cell: cell)
                }}
            )
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: {_ in
            UIView.animate(withDuration: 0.1, delay: 0, options: [.curveLinear]) {
                cell.animationView.isHidden = true
                cell.wrapperView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
                
            })
            menu.addAction(deleteAtion)
            menu.addAction(cancelAction)
            self.present(menu, animated: true, completion: nil)
            menu.removeErrorConstraints()
       }
    
    func deleteCell(cell: NotesCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            collectionView.performBatchUpdates({
                self.deleteNoteReference(index: indexPath.row)
                notesViewModel.deleteNote(index: indexPath.row)
                collectionView.deleteItems(at: [indexPath])
                if searchActive {
                    notesViewModel.filterNotes(string: textSearch)
                } else {
                    notesViewModel.restartNotes()
                    self.updateUI()
                }
            }, completion: {_ in
                cell.animationView.isHidden = true
                cell.wrapperView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
    }
    
    func deleteNoteReference(index: Int) {
        if let noteViewModel = notesViewModel.noteAtIndex(index),
           let keyVerse = noteViewModel.keyVerse {
            UserDefaultsPersistence.shared.setNilNoteId(key: keyVerse)
        }
    }
    
    func updateUI() {
        if notesViewModel.isEmpty() {
            initialLabel.isHidden = false
            navigationItem.searchController = nil
        } else {
            initialLabel.isHidden = true
        }
        collectionView.reloadData()
    }
    
    func noteIsUpdated() {
        notesViewModel.restartNotes()
        updateUI()
    }
}
