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
    var collectionView : UICollectionView?
    let backView = BackView()
           
    var notas:[Nota] = [] {
        didSet{
            if notas.isEmpty{
                initialLabel.text = "Clique + para adicionar uma nova anotação."
            }else{
                initialLabel.text = " "
            }
        }
    }
    
    
    let initialLabel: UILabel = {
        var label = UILabel()
        label.textColor = .myGray
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    
   
      // MARK: Lifecycle
      override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addBackground()
        addTextInicial()
       
        notas = NotaService.shared.buscaNotas()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
         
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        collectionView?.register(NotasCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
         
       collectionView?.backgroundColor = .clear
      
        collectionView?.delegate = self
        collectionView!.dataSource = self
      
        view.insertSubview(collectionView ?? UICollectionView(), at: 1)
        
      }
      
      // MARK: Selectors
       
    @objc func addNota(){
        
          let novaNota = NovaNota()
        novaNota.nota = Nota()
        novaNota.modalPresentationStyle = .fullScreen
        self.present(novaNota, animated: true)
    }
       
       // MARK: Helpers
    
      
      func configureUI(){
    
        navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = .blueBackgroud
        navigationItem.title = "Anotações"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNota))
    
    }

    func addTextInicial(){
        backView.addSubview(initialLabel)
        initialLabel.anchor(left: backView.leftAnchor, right: backView.rightAnchor,paddingLeft: 16, paddingRight: 16)
        initialLabel.centerY(inView: backView)
    }
    
    func addBackground(){
         
          let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let statusBarHeight = (window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0) + (navigationController?.navigationBar.frame.height ?? 0 )
          let tabBarHeight = self.tabBarController?.tabBar.frame.size.height ?? 0
          view.insertSubview(backView, at: 0)
          backView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: statusBarHeight, paddingLeft: 8, paddingBottom: tabBarHeight, paddingRight: 8)
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
        myCell.viewController = self
        myCell.delegate = self
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth =  collectionView.frame.width / 2 - 15
        let cellHeigth = collectionView.frame.height / 5 - 10
        return CGSize(width: cellWidth, height: cellHeigth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let visualizarNota = VisualizarNotaViewController()
        visualizarNota.nota = notas[indexPath.row]
        visualizarNota.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(visualizarNota, animated: true)
    }


    
}
extension NotasViewController: NotasCellDelegate{
    func deleteCell(cell: NotasCollectionViewCell) {
        if let indexPath = collectionView?.indexPath(for: cell){
            notas.remove(at: indexPath.row)
            collectionView?.deleteItems(at: [indexPath])
        }
    }
    
    
}
