//
//  ContextMenuExtension.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 08/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit
import Foundation

extension BibleViewController {
    
    func getSelectedIndexes() -> [Int]? {
        var indexes = [Int]()
        if let allIndexesPath = self.tableView.indexPathsForSelectedRows {
            for index in allIndexesPath {
                indexes.append(index.row)
            }
            return indexes
        }
        
        return nil
    }
    
    func shareVerse(indexes: [Int]) {
        if let verses = actualChapter?.getSelectedVerses(selectedIndexes: indexes) {
            let viewActivity = UIActivityViewController(activityItems: [verses], applicationActivities: [])
            self.present(viewActivity, animated: true)
        }
    }
    
    func addNewNote(text: String) {
        let newNote = NoteViewModel(service: service,
                                    text: text,
                                    color: 1)
        let novaNotaViewController = CreateAndEditNoteViewController(service: service,
                                                                     noteViewModel: newNote,
                                                                     action: .create)
        novaNotaViewController.modalPresentationStyle = .fullScreen
        self.present(novaNotaViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   contextMenuConfigurationForRowAt indexPath: IndexPath,
                   point: CGPoint) -> UIContextMenuConfiguration? {
        let identifier = "\(indexPath.row)" as NSString
        let indexes: [Int] = self.getSelectedIndexes() ?? [indexPath.row]
        
        return UIContextMenuConfiguration(identifier: identifier, previewProvider: nil) { _  in
            let copyAction = UIAction(title: "copiar", image: UIImage(systemName: "doc.on.doc")) { _ in
                    UIPasteboard.general.string = self.actualChapter?.getSelectedVerses(selectedIndexes: indexes)
            }
            
            let shareAction = UIAction(title: "compartilhar", image: UIImage(systemName: "square.and.arrow.up")) { _ in
                self.shareVerse(indexes: indexes)
            }
            
            let newNoteAction = UIAction(title: "criar nota", image: UIImage(systemName: "doc.badge.plus")) { _ in
    
                self.addNewNote(text: self.actualChapter?.getSelectedVerses(
                                    selectedIndexes: indexes) ?? "")
            }
            
            return UIMenu(title: "", image: nil, children: [copyAction, shareAction, newNoteAction])
        }
       
    }
}
