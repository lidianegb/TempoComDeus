//
//  UserDefaultsPersistence.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 03/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.

import Foundation
struct  UserDefaultsPersistence {
    static let shared = UserDefaultsPersistence()
    private let defaults = UserDefaults.standard

    func setupDefaultsValues() {
        if defaults.object(forKey: ABBR) != nil { } else {
            defaults.set("gn", forKey: ABBR)
        }
        
        if defaults.object(forKey: VERSION) != nil { } else {
            defaults.set(NVI, forKey: VERSION)
        }
        
        if defaults.object(forKey: CHAPTER) != nil { } else {
            defaults.set(0, forKey: CHAPTER)
        }
        
        if defaults.object(forKey: FONTSIZE) != nil {} else {
            defaults.set(17, forKey: FONTSIZE)
        }
    }
    
    func getDefaultChapter() -> Int {
        defaults.integer(forKey: CHAPTER)
    }
    
    func getDefaultAbbrev() -> String {
        defaults.string(forKey: ABBR) ?? "gn"
    }
    
    func getDefaultVersion() -> String {
        defaults.string(forKey: VERSION) ?? NVI
    }
    
    func getDefaultFontSize() -> Int {
        defaults.integer(forKey: FONTSIZE)
    }
    
    func updateFontSize(size: Int) {
        defaults.set(size, forKey: FONTSIZE)
    }
    
    func updateDefaultValues(actualChapter: Chapter?) {
        guard let actualChapter = actualChapter else { return }
        defaults.set(actualChapter.abbreviation, forKey: ABBR)
        defaults.set(actualChapter.number, forKey: CHAPTER)
        defaults.set(actualChapter.version, forKey: VERSION)
    }
    
}
