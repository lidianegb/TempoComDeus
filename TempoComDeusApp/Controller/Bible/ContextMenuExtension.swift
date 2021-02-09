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
    
    func addNewNote(text: String, indexPath: IndexPath) {
        let newNote = NoteViewModel(service: service,
                                    text: text,
                                    color: 1)
        let novaNotaViewController = CreateAndEditNoteViewController(service: service,
                                                                     noteViewModel: newNote,
                                                                     action: .create)
        novaNotaViewController.verse = verses[indexPath.row]
        guard let bibleCell = tableView.cellForRow(at: indexPath) as? BibleTableViewCell else { return }
        bibleCell.actualVerse = verses[indexPath.row]
        
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
            
            var noteAction: UIAction!
            if self.verses[indexPath.row].noteId == nil {
                noteAction = UIAction(title: "criar nota", image: UIImage(systemName: "doc.badge.plus")) { _ in
                    
                    self.addNewNote(text: self.actualChapter?.getReferenceVerse(
                                        selectedIndex: indexPath) ?? "", indexPath: indexPath)
                }
            } else {
                noteAction = UIAction(title: "ver nota", image: UIImage(systemName: "doc")) { _ in
                    print(self.verses[indexPath.row].noteId ?? "nil")
                }
            }
            
            return UIMenu(title: "", image: nil, children: [copyAction, shareAction, noteAction])
        }
       
    }
}
