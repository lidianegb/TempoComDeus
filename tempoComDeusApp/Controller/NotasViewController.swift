//
//  NotasViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

protocol NotaDelegate: UIViewController {
    func didChange(body: String, cor: String)
}


class NotasViewController: UIViewController {

    // MARK: Properties
    
    let cellId = "CellId"
    var collectionView : UICollectionView?
    let backView = BackView()
    
    private var notaRepository: NotaRepository {
          NotaRepository()
    }
    
    var notas: [Nota] = [] {
         didSet {
             if notas.isEmpty {
                initialLabel.isHidden = false
                collectionView?.isHidden = true
             } else {
                collectionView?.isHidden = false
                initialLabel.isHidden = true
            }
            collectionView?.reloadData()
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

    
   
      // MARK: Lifecycle
      override func viewDidLoad() {
        super.viewDidLoad()
       notas = notaRepository.readAllItems()
        
        configureUI()
        addBackground()
        // Setup view

        addTextInicial()
        
        setupCollectionView()
      }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
           notas = notaRepository.readAllItems()
       }
      
      // MARK: Selectors

       
    @objc  func showNewNota(){
        let notaViewController = NovaNota(notaRepository: notaRepository, id: UUID())
        notaViewController.modalPresentationStyle = .fullScreen
        self.present(notaViewController, animated: true)
    }
       // MARK: Helpers
    
      
      func configureUI(){
    
        navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = .blueBackgroud
        navigationItem.title = "Anotações"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showNewNota))
    
    }

    func addTextInicial(){
        backView.addSubview(initialLabel)
        initialLabel.anchor(left: backView.leftAnchor, right: backView.rightAnchor,paddingLeft: 16, paddingRight: 16)
        initialLabel.centerY(inView: backView)
    }
    
    func addBackground(){
        view.addSubview(backView)
          backView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8)
      }
    
    func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
                
       collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
       
       collectionView?.register(NotasCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
      collectionView?.backgroundColor = .clear
     
       collectionView?.delegate = self
       collectionView!.dataSource = self
     
       view.addSubview(collectionView ?? UICollectionView())
        
       }
}

extension NotasViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        notas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NotasCollectionViewCell
        
        myCell.nota = notas[indexPath.row]
        myCell.createCell()
        myCell.delegate = self
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth =  collectionView.frame.width / 2 - 15
        let cellHeigth = collectionView.frame.height / 5 - 10
        return CGSize(width: cellWidth, height: cellHeigth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let visualizarNota = VisualizarNotaViewController(notaRepository: notaRepository, id: notas[indexPath.row].id)
        visualizarNota.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(visualizarNota, animated: true)
    }


    
}
extension NotasViewController: NotasCellDelegate{
    func deleteCell(cell: NotasCollectionViewCell) {
        if let indexPath = collectionView?.indexPath(for: cell){
            collectionView?.performBatchUpdates({
                notaRepository.delete(id: notas[indexPath.row].id)
                collectionView?.deleteItems(at: [indexPath])
                notas = notaRepository.readAllItems()
            }, completion: nil)
        }
    }
}
