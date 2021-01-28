//
//  NotasViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class NotasViewController: UIViewController {

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
    
    var notaRepository: NotaRepository {
          NotaRepository()
    }
    
    var notas: [Nota] = [] {
         didSet {
             if notas.isEmpty {
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
        notas = notaRepository.readAllItems()
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
        let novaNotaViewController = CriarEditarNota(notaRepository: notaRepository, notaId: UUID(), acao: .criar)
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
       collectionView.register(NotasCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
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
}

extension NotasViewController: NotasCellDelegate {
    func deleteCell(cell: NotasCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            collectionView.performBatchUpdates({
               _ = notaRepository.delete(itemId: notas[indexPath.row].notaId)
                collectionView.deleteItems(at: [indexPath])
                notas = notaRepository.readAllItems()
            }, completion: nil)
        }
    }
}

extension NotasViewController: NovaNotaDelegate {
    func updateNotas(notas: [Nota]) {
        self.notas = notas
    }
}

extension NotasViewController: UpdateNotaDelegate {
    func notaIsUpdated(updated: Bool) {
        if updated {
            notas = notaRepository.readAllItems()
        }
    }
}
