//
//  CoreDataService.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 04/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
import CoreData

class CoreDataService {
    
    var viewContext: NSManagedObjectContext!
    
    init(_ context: NSManagedObjectContext) {
        self.viewContext = context
    }
    
    func fetchNotes(predicate: NSPredicate? = nil) -> [NoteModel] {
        var notesModel = [NoteModel]()
        do {
            let request = NoteModel.fetchRequest() as NSFetchRequest<NoteModel>
            if predicate != nil {
                request.predicate = predicate
            }
            notesModel = try viewContext.fetch(request)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return notesModel
    }
    
    func saveContext () {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func create(text: String, color: Int16) -> NoteModel {
        let note = NoteModel(context: viewContext)
        note.noteId = UUID()
        note.color = 1
        note.text = text
        note.color = color
        saveContext()
        return note
    }

    func fetchNoteById(noteId: UUID) -> NoteModel? {
        let predicate = NSPredicate(format: "noteId == %@", noteId.description)
        return fetchNotes(predicate: predicate).first
    }
    
    func delete(noteModel: NoteModel?) {
        if let noteModel = noteModel {
            viewContext.delete(noteModel)
            saveContext()
        }
    }
    
}
