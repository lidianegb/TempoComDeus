//
//  NotesCollectionDelegates.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 06/01/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
import UIKit

extension NotesViewController: UICollectionViewDataSource, UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId,
                                                              for: indexPath) as? NotesCollectionViewCell
            else {return UICollectionViewCell()}
         
        myCell.nota = notes[indexPath.row]
        myCell.createCell()
        myCell.onDeleteCell = { cell in
            self.displayActionSheet(cell: cell)
        }
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
    
        let viewNote = ViewNoteViewController(notaRepository: noteRepository,
                                                          notaId: notes[indexPath.row].notaId)
        viewNote.noteIsUpdated = { updated in
            self.notaIsUpdated(updated: updated)
        }
        
        viewNote.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewNote, animated: true)
    }

}
