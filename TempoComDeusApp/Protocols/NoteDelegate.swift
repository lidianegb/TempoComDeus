//
//  NoteDelegate.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 02/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation

protocol NoteDelegate: class {
    func didChange(body: String, color: String, noteId: UUID)
}
