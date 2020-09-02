//
//  NotaDelegate.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 02/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation

protocol NotaDelegate: class {
    func didChange(body: String, cor: String, notaId: UUID)
}
