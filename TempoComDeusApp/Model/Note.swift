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
    var color: Int
        
    init(body: String?, color: Int) {
        self.notaId = UUID()
        self.body = body ?? String()
        self.date  = Date()
        self.color = color
    }
    
    private enum CodingKeys: String, CodingKey {
        case notaId, body, date, color
    }
    
    func updateColor(_ newColorNumber: Int) {
        self.color = newColorNumber
    }
        
}
