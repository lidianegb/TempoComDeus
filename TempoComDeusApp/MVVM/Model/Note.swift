//
//  Note.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.

import Foundation

class Note: Codable {
    
    let noteId: UUID
    var body: String
    let date: Date
    var color: Int
        
    init(body: String = "", color: Int = 1) {
        self.noteId = UUID()
        self.body = body
        self.date  = Date()
        self.color = color
    }
    
    private enum CodingKeys: String, CodingKey {
        case noteId, body, date, color
    }
    
    func updateColor(_ newColorNumber: Int) {
        self.color = newColorNumber
    }
        
}
