//
//  MyColors.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 02/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.

import UIKit
import Foundation

class MyColors {
    static let highlighted = UIColor.rgb(red: 0, green: 255, blue: 255)
    static let blueActLight = UIColor.rgb(red: 6, green: 181, blue: 209)
    static let backgroudColorLight = UIColor.rgb(red: 228, green: 246, blue: 250)
    static let blueClearLight = UIColor.rgb(red: 148, green: 223, blue: 235)
    static let backColorLight = UIColor.rgb(red: 255, green: 255, blue: 255)
       
    static let highlightedDark = UIColor.rgb(red: 0, green: 130, blue: 142)
    static let blueActDark = UIColor.rgb(red: 0, green: 188, blue: 217)
    static let backgroudColorDark = UIColor.rgb(red: 0, green: 0, blue: 0)
    static let blueClearDark = UIColor.rgb(red: 106, green: 138, blue: 144)
    static let backColorDark = UIColor.rgb(red: 19, green: 20, blue: 21)
    
    static let noteColor1Light = UIColor.rgb(red: 254, green: 231, blue: 231)
    static let noteColor2Light = UIColor.rgb(red: 230, green: 235, blue: 246)
    static let noteColor3Light = UIColor.rgb(red: 217, green: 216, blue: 216)
    static let noteColor4Light = UIColor.rgb(red: 206, green: 224, blue: 213)
    static let noteColor5Light = UIColor.rgb(red: 255, green: 224, blue: 207)
    
    static let noteColor1Dark = UIColor.rgb(red: 184, green: 122, blue: 122)
    static let noteColor2Dark = UIColor.rgb(red: 122, green: 142, blue: 184)
    static let noteColor3Dark = UIColor.rgb(red: 77, green: 76, blue: 75)
    static let noteColor4Dark = UIColor.rgb(red: 64, green: 99, blue: 91)
    static let noteColor5Dark = UIColor.rgb(red: 222, green: 126, blue: 74)
    
    private static let allNoteColors = [UIColor.noteColor1,
                                UIColor.noteColor2,
                                UIColor.noteColor3,
                                UIColor.noteColor4,
                                UIColor.noteColor5]
    
    static func getColorNumber(color: CGColor) -> Int {
        for (indice, note) in allNoteColors.enumerated() where note.cgColor == color {
                return indice + 1
        }
        return 0
    }
}
