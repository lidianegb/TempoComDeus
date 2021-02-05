//
//  NotesViewModel.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 03/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.

import Foundation
import CoreData
class NotesViewModel {
    private var notes = [NoteViewModel]()
   
    init(context: NSManagedObjectContext) {
        self.notes = fillNotes(notes: fetchNotes(context: context))
        self.notes.reverse()
    }
    
    func restartNotes(context: NSManagedObjectContext) {
        self.notes.removeAll()
        self.notes = fillNotes(notes: fetchNotes(context: context))
        self.notes.reverse()
    }
    
    private func fetchNotes(context: NSManagedObjectContext) -> [NoteModel] {
        CoreDataService.shared.fetchAllNotes(context: context, predicate: nil)
    }
    
    private func fillNotes(notes: [NoteModel]) -> [NoteViewModel] {
        var notesViewModel = [NoteViewModel]()
        for note in notes {
            let noteViewModel = NoteViewModel(noteModel: note)
            notesViewModel.append(noteViewModel)
        }
        return notesViewModel
    }
    
    func isEmpty() -> Bool {
        notes.count == 0
    }
    
    func numberOfNotes() -> Int {
        notes.count
    }
    
    func noteAtIndex(_ index: Int) -> NoteViewModel {
        notes[index]
    }
    
    func deleteNote(context: NSManagedObjectContext, index: Int) {
        let noteViewModel = noteAtIndex(index)
        let noteModel = noteViewModel.fetchNote(context: context, noteId: noteViewModel.noteId)
        CoreDataService.shared.delete(context: context, noteModel: noteModel)
    }
    
    func noteIdAtIndex(_ index: Int) -> UUID {
        notes[index].noteId
    }
}
