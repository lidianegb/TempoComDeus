//
//  NoteModel.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 04/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
import CoreData

@objc(NotaModel)
extension NoteModel {
    func setValues(noteId: UUID, text: String, color: Int16, date: Date) {
        self.noteId = noteId
        self.text = text
        self.color = color
        self.date = date
    }
    func updateNote(text: String, color: Int16) {
        self.text = text
        self.color = color
    }
}
