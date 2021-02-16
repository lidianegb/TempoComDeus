//
//  Calculator.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 04/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
struct Calculator {
    static func calculeBooksTableViewCellHeight(totalItems: Double) -> Double {
        let heigth = ceil(totalItems / 7.0)
        return  (heigth == 1 ? 70 : heigth * 50 + 20)
    }
    
    static func calculeNotesCollectionViewCellSize(width: Float, height: Float) -> (width: Float, height: Float) {
        let cellWidth =  width / 2 - 15
        let cellHeigth = cellWidth
        
        return (width: cellWidth, height: cellHeigth)
    }
}
