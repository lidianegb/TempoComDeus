//
//  NotesViewModel.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 03/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.

import Foundation
class NotesViewModel {
    private var notes = [NoteViewModel]()
    var noteRepository: NoteRepository
    
    init(noteRepository: NoteRepository) {
        self.noteRepository = noteRepository
        updateNotes()
    }
    
    func updateNotes() {
        notes.removeAll()
        let notes = noteRepository.readAllItems()
        for note in notes {
            let noteViewModel = NoteViewModel(note: note)
            self.notes.append(noteViewModel)
        }
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
    
    func noteIdAtIndex(_ index: Int) -> UUID {
        notes[index].noteId
    }
}
