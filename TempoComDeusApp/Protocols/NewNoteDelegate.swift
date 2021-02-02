//
//  NewNoteDelegate.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 02/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
import UIKit
protocol NewNotaDelegate: class {
    func getNote(note: Note)
    func updateHeightOfRow(_ cell: NoteTableViewCell, _ textView: UITextView)
    func getVerses(verses: [Chapter])
}

protocol ChangeColorDelegate: class {
    func didChangeColor(color: String)
}
