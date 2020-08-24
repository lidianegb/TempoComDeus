//
//  CreateNewBibliaTest.swift
//  ApplicationTests
//
//  Created by Lidiane Gomes Barbosa on 24/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//
//swiftlint:disable trailing_whitespace
import XCTest
@testable import tempo_com_Deus
class CreateNewBibliaTest: XCTestCase {
    
    // biblia data
    var livro: Livro!
    var capitulo: Capitulo!
    var verso: Verso!
    var biblia: Biblia!
    
    // livro data
    let nameLivro = "Salmos"
    let author = "Davi"
    let chapters = 150
    
    // capitulo data
    let number = 10
    let verses = 29
    
    // verse data
    let numberVerse = 10
    let text = "verso 10"
   
    override func setUp() {
       
        livro = Livro(abbrev: ["pt": "sl"],
                      name: nameLivro,
                      author: author,
                      chapters: chapters,
                      group: "Poéticos",
                      testament: "AT",
                      version: "nvi")
        
        capitulo = Capitulo(number: number, verses: verses)

        verso = Verso(number: numberVerse, text: text)
        
    }
    
    func test_create_newBiblia() {
        biblia = Biblia(book: livro, chapter: capitulo, verses: [verso])
        
        let output1 = biblia.book.author
        let output2 = biblia.chapter.number
        let output3 = biblia.verses.count
        
        XCTAssertEqual(output1, author)
        XCTAssertEqual(output2, number)
        XCTAssertEqual(output3, 1)
        
    }
    func test_create_newLivro() {
        let outputName = livro.name
        let outputAuthor = livro.author
        let outpitChapters = livro.chapters
              
              // then
        XCTAssertEqual(outputName, nameLivro)
        XCTAssertEqual(outputAuthor, author)
        XCTAssertEqual(outpitChapters, chapters)
    }
    
    func test_create_newCapitulo() {
           let outputNumber = capitulo.number
           let outputVerses = capitulo.verses
           // then
           XCTAssertEqual(outputNumber, number)
           XCTAssertEqual(outputVerses, verses)
       }
    
    func test_create_newVerse() {
        let output1 = verso.number
        let output2 = verso.text
             
             //Then
         XCTAssertEqual(output1, numberVerse)
         XCTAssertEqual(output2, text)
    }
    
    override func tearDown() {
        livro = nil
        capitulo = nil
        verso = nil
        
    }
}
