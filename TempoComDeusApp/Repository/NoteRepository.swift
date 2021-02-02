//
//  NoteRepository.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 17/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation

class NoteRepository: Repository {
    
    typealias Item = Note
    var items: [Note] = []
}
