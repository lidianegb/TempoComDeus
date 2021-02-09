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
    
    func getSelectedIndexes() -> [IndexPath] {
        var indexes = [IndexPath]()
        if let allIndexesPath = self.tableView.indexPathsForSelectedRows {
            for index in allIndexesPath {
                indexes.append(index)
            }
        }
        return indexes
    }
    
    func shareVerses(indexes: [IndexPath]) {
        if let verses = actualChapter?.getSelectedVersesText(selectedIndexes: indexes) {
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
        var indexesPath = self.getSelectedIndexes()
        if !indexesPath.contains(indexPath) {
            indexesPath.append(indexPath)
        }
        let indexes = indexesPath.sorted()
        
        return UIContextMenuConfiguration(identifier: identifier, previewProvider: nil) { _  in
            let copyAction = UIAction(title: "copiar", image: UIImage(systemName: "doc.on.doc")) { _ in
                    UIPasteboard.general.string = self.actualChapter?.getSelectedVersesText(selectedIndexes: indexes)
            }
            
            let shareAction = UIAction(title: "compartilhar", image: UIImage(systemName: "square.and.arrow.up")) { _ in
                self.shareVerses(indexes: indexes)
            }
            
            let newNoteAction = UIAction(title: "criar nota", image: UIImage(systemName: "doc.badge.plus")) { _ in
    
                self.addNewNote(text: self.actualChapter?.getReferenceVerse(selectedIndex: indexPath) ?? "")
            }
            
            return UIMenu(title: "", image: nil, children: [copyAction, shareAction, newNoteAction])
        }
       
    }
}
