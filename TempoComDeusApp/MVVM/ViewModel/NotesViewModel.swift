//
//  NotesViewModel.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 03/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.

import Foundation
import CoreData
class NotesViewModel {
    var notes = [NoteViewModel]()
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
    
    func noteAtIndex(_ index: Int) -> NoteViewModel? {
        if !isEmpty() {
            return  notes[index]
        }
       return nil
    }
    
    func deleteNote(index: Int) {
        if let noteViewModel = noteAtIndex(index) {
            let noteModel = noteViewModel.fetchNote(noteId: noteViewModel.noteId)
            service.delete(noteModel: noteModel)
        }
    }
    
    func noteIdAtIndex(_ index: Int) -> UUID? {
        if !isEmpty() {
            return   notes[index].noteId
        }
       return nil
    }
    
    func filterNotes(string: String) {
        var result = [NoteViewModel]()
        var allNotes = fillNotes(notes: fetchNotes())
        allNotes.reverse()
        for note in allNotes where note.text.lowercased().contains(string.lowercased()) {
            result.append(note)
        }
        self.notes.removeAll()
        self.notes = result
    }
}
