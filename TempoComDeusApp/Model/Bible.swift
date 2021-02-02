//
//  Bible.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation

class Bible {

    var books = [Book]()
    
    func getBookName(bookResume: BookResume) -> String {
        for book in books where book.abbrev["pt"] == bookResume.abbrev {
            return book.name
        }
        
        return ""
    }
    
}
