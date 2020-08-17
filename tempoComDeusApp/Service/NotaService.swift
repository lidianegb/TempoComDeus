//
//  NotaService.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 14/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation


class NotaService{
    static let shared = NotaService()

    private let notas: [Nota] = []
    
    func buscaNotas() -> [Nota]{
        return notas
    }
}
