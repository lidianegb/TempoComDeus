//
//  NoteViewModel.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 03/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.

import Foundation
import CoreData
class NoteViewModel {
    var note: NoteModel!
    private var service: CoreDataService
    var noteId: UUID {
        self.note.noteId ?? UUID()
    }
    var text: String {
        self.note.text ?? ""
    }
    var date: Date {
        self.note.date ?? Date()
    }
    var color: Int16 {
        self.note.color
    }

    init(service: CoreDataService, noteModel: NoteModel) {
        self.note = noteModel
        self.service = service
    }
    
    init(service: CoreDataService, noteId: UUID) {
        self.service = service
        self.note = self.fetchNote(noteId: noteId)
    }
    
    init(service: CoreDataService, text: String, color: Int16) {
        self.service = service
        self.note = service.create(text: text, color: color)
    }
    
    func fetchNote(noteId: UUID) -> NoteModel? {
        service.fetchNoteById(noteId: noteId)
    }
  
    func updateNote(text: String, color: Int16) {
        self.note.updateNote(text: text, color: color)
        service.saveContext()
    }
}
