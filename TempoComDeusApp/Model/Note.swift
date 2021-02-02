//
//  Note.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation

class Note: Codable {
    
    let notaId: UUID
    var body: String
    let date: Date
    var color: String
    var verses: [Chapter]
        
    init(body: String?, color: String?, versos: [Chapter]) {
        self.notaId = UUID()
        self.body = body ?? String()
        self.date  = Date()
        self.color = color ?? String()
        self.verses = versos
    }
    private enum CodingKeys: String, CodingKey {
        case notaId, body, date, color, verses
    }
        
}
