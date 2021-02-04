//
//  NoteViewModel.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 03/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.

import Foundation
import CoreData
class NoteViewModel {
    private var note: NoteModel?
    private var context: NSManagedObjectContext!
    
    var noteId: UUID {
        self.note?.noteId ?? UUID()
    }
    var text: String {
        self.note?.text ?? ""
    }
    var date: Date {
        self.note?.date ?? Date()
    }
    var color: Int16 {
        self.note?.color ?? 1
    }
    
    init(context: NSManagedObjectContext, noteId: UUID) {
        self.context = context
        if let note = self.fetchNote(noteId: noteId) {
            self.note = note
        } else {
            createNote()
        }
    }
    
    init(noteModel: NoteModel) {
        self.note = noteModel
    }
    
    func fetchNote(noteId: UUID) -> NoteModel? {
        CoreDataService.shared.fetchNote(context: context, noteId: noteId)
    }
  
    func updateNote(text: String, color: Int16) {
        note?.updateNote(text: text, color: color)
        CoreDataService.shared.save(context: context)
    }
    
    func createNote() {
        self.note = NoteModel(context: context)
        note?.setValues(noteId: UUID(), text: "", color: 1, date: Date())
        CoreDataService.shared.save(context: context)
    }
}
