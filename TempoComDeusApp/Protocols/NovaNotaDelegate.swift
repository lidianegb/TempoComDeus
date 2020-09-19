//
//  NovaNotaDelegate.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 02/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
import UIKit
protocol NovaNotaDelegate: class {
    func updateNotas(notas: [Nota])
}

protocol NewNotaDelegate: class {
    func getNota(nota: Nota)
    func updateHeightOfRow(_ cell: NotaTableViewCell, _ textView: UITextView)
    func getVersos(versos: [Verso])
}

protocol ChangeColorDelegate: class {
    func didChangeColor(color: String)
}
