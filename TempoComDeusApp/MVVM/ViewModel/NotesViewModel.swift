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
    var service: CoreDataService
   
    init(service: CoreDataService) {
        self.service = service
        self.notes = fillNotes(notes: fetchNotes())
        self.notes.reverse()
    }
    
    func restartNotes() {
        self.notes.removeAll()
        self.notes = fillNotes(notes: fetchNotes())
        self.notes.reverse()
    }
    
    private func fetchNotes() -> [NoteModel] {
        service.fetchNotes()
    }
    
    private func fillNotes(notes: [NoteModel]) -> [NoteViewModel] {
        var notesViewModel = [NoteViewModel]()
        for note in notes {
            let noteViewModel = NoteViewModel(service: service, noteModel: note)
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
    
    func deleteNote(index: Int) {
        let noteViewModel = noteAtIndex(index)
        let noteModel = noteViewModel.fetchNote(noteId: noteViewModel.noteId)
        service.delete(noteModel: noteModel)
    }
    
    func noteIdAtIndex(_ index: Int) -> UUID {
        notes[index].noteId
    }
}
