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
        
    init(body: String?, cor: String?) {
        self.notaId = UUID()
        self.body = body ?? ""
        self.date  = Date()
        self.cor = cor ?? ""
    }
    private enum CodingKeys: String, CodingKey {
        case notaId, body, date, cor
    }
        
}
