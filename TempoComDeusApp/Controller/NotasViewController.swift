//
//  NotasViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

protocol NotaDelegate: class {
    func didChange(body: String, cor: String)
}

class NotasViewController: UIViewController {

    // MARK: Properties
    
    let cellId = "CellId"
    let backView = BackView()
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
                       
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)

        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private var notaRepository: NotaRepository {
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
        label.textColor = .myGray
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    let titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Anotações"
        label.textColor = .blueAct
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
   
      // MARK: Lifecycle
      override func viewDidLoad() {
        super.viewDidLoad()
        notas = notaRepository.readAllItems()
        
        configureUI()
        addBackground()
        addTextInicial()
        setupCollectionView()
      }
      
      // MARK: Selectors

    @objc func showNewNota() {
        let notaViewController = NovaNota(notaRepository: notaRepository, notaId: UUID())
        notaViewController.modalPresentationStyle = .fullScreen
        notaViewController.delegate = self
        self.present(notaViewController, animated: true)
    }
       // MARK: Helpers
    
    func configureUI() {
        navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = .blueBackgroud
        navigationItem.titleView = titleLabel
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(showNewNota))
    
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
        
       }
}

extension NotasViewController: UICollectionViewDataSource, UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        notas.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId,
                                                              for: indexPath) as? NotasCollectionViewCell
            else {return UICollectionViewCell()}
        
        myCell.nota = notas[indexPath.row]
        myCell.createCell()
        myCell.delegate = self
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.frame.width
        let collectionHeight = collectionView.frame.height
        return calcCellWidthAndHeight(width: collectionWidth, height: collectionHeight)
    }
    
    func calcCellWidthAndHeight(width: CGFloat, height: CGFloat) -> CGSize {
        let cellWidth =  width / 2 - 15
        let cellHeigth = height / 5 - 10
        
        return CGSize(width: cellWidth, height: cellHeigth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let visualizarNota = VisualizarNotaViewController(notaRepository: notaRepository,
                                                          notaId: notas[indexPath.row].notaId)
        visualizarNota.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(visualizarNota, animated: true)
    }

}
extension NotasViewController: NotasCellDelegate {
    func deleteCell(cell: NotasCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            collectionView.performBatchUpdates({
                notaRepository.delete(itemId: notas[indexPath.row].notaId)
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
