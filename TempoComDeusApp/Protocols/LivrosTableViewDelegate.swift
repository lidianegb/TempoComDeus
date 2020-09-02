//
//  LivrosTableViewDelegate.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 02/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation

protocol LivrosTableViewDelegate: class {
    func didSelectSection(abbr: String, chapter: Int)
}
