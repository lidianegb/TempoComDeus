//
//  CoreDataService.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 04/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataService {
    
    static let shared = CoreDataService()
    
    func fetchAllNotes(context: NSManagedObjectContext, predicate: NSPredicate?) -> [NoteModel] {
        var notesModel = [NoteModel]()
        do {
            let request = NoteModel.fetchRequest() as NSFetchRequest<NoteModel>
            if predicate != nil {
                request.predicate = predicate
            }
            notesModel = try context.fetch(request)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return notesModel
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func fetchNoteById(context: NSManagedObjectContext, noteId: UUID) -> NoteModel? {
        let predicate = NSPredicate(format: "noteId == %@", noteId.description)
        return fetchAllNotes(context: context, predicate: predicate).first
    }
    
    func delete(context: NSManagedObjectContext, noteModel: NoteModel?) {
        if let noteModel = noteModel {
            context.delete(noteModel)
            save(context: context)
        }
    }
    
}
