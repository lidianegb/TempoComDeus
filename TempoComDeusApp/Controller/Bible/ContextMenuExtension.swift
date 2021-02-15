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
                   previewForHighlightingContextMenuWithConfiguration
                    configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        guard let identifier = configuration.identifier as? String, let index = Int(identifier),
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? BibleTableViewCell
        else { return nil }
        return UITargetedPreview(view: cell.contentView)
    }
    
    func tableView(_ tableView: UITableView,
                   contextMenuConfigurationForRowAt indexPath: IndexPath,
                   point: CGPoint) -> UIContextMenuConfiguration? {
        let identifier = "\(indexPath.row)" as NSString
        var listIndexs = self.getSelectedIndexes()
        if !listIndexs.contains(indexPath) {
            listIndexs.append(indexPath)
        }
        let indexes = listIndexs.sorted()
        guard let actualChapter = actualChapter else {return nil}
        
        return UIContextMenuConfiguration(identifier: identifier, previewProvider: nil) { _  in
            let copyAction = UIAction(title: "copiar", image: UIImage(systemName: "doc.on.doc")) { _ in
                    UIPasteboard.general.string = actualChapter.getSelectedVersesText(selectedIndexes: indexes)
            }
            
            let shareAction = UIAction(title: "compartilhar", image: UIImage(systemName: "square.and.arrow.up")) { _ in
                self.shareVerses(indexes: indexes)
            }
            
            guard let noteID = self.verses[indexPath.row].noteId else {
                let newNoteAction = UIAction(title: "criar nota", image: UIImage(systemName: "doc.badge.plus")) { _ in
                    
                    self.addNewNote(text: actualChapter.getSelectedVersesText(selectedIndexes: indexes) + "\n",
                                    indexPath: indexPath)
                }
                
                return UIMenu(title: "", image: nil, children: [copyAction, shareAction, newNoteAction])
            }
            let viewNoteAction = UIAction(title: "ver nota", image: UIImage(systemName: "doc")) { _ in
                let noteViewModel = NoteViewModel(service: self.service, noteId: noteID)
                let viewNote = ViewNoteViewController(service: self.service,
                                                      noteViewModel: noteViewModel)
                viewNote.modalPresentationStyle = .fullScreen
                self.present(viewNote, animated: true)
            }
            return UIMenu(title: "", image: nil, children: [copyAction, shareAction, viewNoteAction])
        }
       
    }
}
