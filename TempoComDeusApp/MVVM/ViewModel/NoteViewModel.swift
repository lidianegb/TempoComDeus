//
//  NoteViewModel.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 03/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
class NoteViewModel {
    private var note: Note
    var noteId: UUID {
        self.note.noteId
    }
    var body: String {
        self.note.body
    }
    var date: Date {
        self.note.date
    }
    var color: Int {
        self.note.color
    }
    
    init(note: Note?) {
        self.note = note ?? Note()
    }
    
    func updateNote(text: String, color: Int, noteRepository: NoteRepository) {
        self.note.body = text
        self.note.color = color
        noteRepository.update(item: self.note)
        self.note = noteRepository.readItem(itemId: self.noteId) ?? Note()
    }
}
