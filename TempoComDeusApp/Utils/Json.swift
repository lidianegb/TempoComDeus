//
//  Json.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 02/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation

enum JsonDetailError: Error {
    case failedToEncoder
    case failedToDecoder
}

extension JsonDetailError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedToDecoder:
            return NSLocalizedString("Erro ao tentar Decodar", comment: "Decoder")
        case .failedToEncoder:
            return NSLocalizedString("Erro ao tentar encodar", comment: "Encoder")
        }
    }
}

class Json {
    func encodeLivro(list: [Livro]) throws -> String {
        let jsonData = try JSONEncoder().encode(list)
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            throw JsonDetailError.failedToEncoder
        }
        return jsonString
     }
    func encodeBiblia(list: [Biblia]) throws -> String {
       let jsonData = try JSONEncoder().encode(list)
       guard let jsonString = String(data: jsonData, encoding: .utf8) else {
           throw JsonDetailError.failedToEncoder
       }
       return jsonString
    }
     
    func decodeBiblia(jsonString: String) throws -> [Biblia] {
       
        guard let jsonData = jsonString.data(using: .utf8) else {
            throw JsonDetailError.failedToDecoder
        }
        let biblia = try JSONDecoder().decode([Biblia].self, from: jsonData)
        return biblia
    }
    
    func decodeLivro(jsonString: String) throws -> [Livro] {
          
           guard let jsonData = jsonString.data(using: .utf8) else {
               throw JsonDetailError.failedToDecoder
           }
           let livro = try JSONDecoder().decode([Livro].self, from: jsonData)
           return livro
    }
}
