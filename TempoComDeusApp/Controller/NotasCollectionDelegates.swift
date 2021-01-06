//
//  NotasCollectionDelegates.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 06/01/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
import UIKit

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
        visualizarNota.delegate = self
        visualizarNota.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(visualizarNota, animated: true)
    }

}
