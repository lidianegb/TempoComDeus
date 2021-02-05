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

    init(noteModel: NoteModel) {
        self.note = noteModel
    }
    
    init(context: NSManagedObjectContext, noteId: UUID) {
        self.note = fetchNote(context: context, noteId: noteId)
    }
    
    init(context: NSManagedObjectContext, text: String, color: Int16) {
        self.note = NoteModel(context: context)
        note?.setValues(noteId: UUID(), text: text, color: color, date: Date())
        CoreDataService.shared.save(context: context)
    }
    
    func fetchNote(context: NSManagedObjectContext, noteId: UUID) -> NoteModel? {
        CoreDataService.shared.fetchNoteById(context: context, noteId: noteId)
    }
  
    func updateNote(context: NSManagedObjectContext, text: String, color: Int16) {
        note?.updateNote(text: text, color: color)
        CoreDataService.shared.save(context: context)
    }
}
