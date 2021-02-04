//
//  NotesViewModel.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 03/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.

import Foundation
class NotesViewModel {
    private var notes = [NoteViewModel]()
    
    init(notes: [Note]) {
        self.notes = fillNotes(notes: notes)
    }
    
    func updateNotes(notes: [Note]) {
        self.notes.removeAll()
        self.notes = fillNotes(notes: notes)
        
    }
    
    private func fillNotes(notes: [Note]) -> [NoteViewModel] {
        var notesViewModel = [NoteViewModel]()
        for note in notes {
            let noteViewModel = NoteViewModel(note: note)
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
    
    func noteIdAtIndex(_ index: Int) -> UUID {
        notes[index].noteId
    }
    
    func calculeCellSize(width: Float, height: Float) -> (width: Float, height: Float) {
        let cellWidth =  width / 2 - 15
        let cellHeigth = height / 5 - 10
        
        return (width: cellWidth, height: cellHeigth)
    }
}
