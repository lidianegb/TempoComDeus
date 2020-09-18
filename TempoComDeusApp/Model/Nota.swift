//
//  NotasModel.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation

class Nota: Codable {
    
    let notaId: UUID
    var body: String
    let date: Date
    var cor: String
    var versos: [Verso]
        
    init(body: String?, cor: String?, versos: [Verso]) {
        self.notaId = UUID()
        self.body = body ?? String()
        self.date  = Date()
        self.cor = cor ?? String()
        self.versos = versos
    }
    private enum CodingKeys: String, CodingKey {
        case notaId, body, date, cor, versos
    }
        
}
