//
//  Json.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 02/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.

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
    
    func encodeLivro(list: [BookResume]) throws -> String {
        let jsonData = try JSONEncoder().encode(list)
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            throw JsonDetailError.failedToEncoder
        }
        return jsonString
     }
    
    func encodeBiblia(list: [Book]) throws -> String {
       let jsonData = try JSONEncoder().encode(list)
       guard let jsonString = String(data: jsonData, encoding: .utf8) else {
           throw JsonDetailError.failedToEncoder
       }
       return jsonString
    }
     
    func decodeBiblia(jsonString: String) throws -> [Book] {
       
        guard let jsonData = jsonString.data(using: .utf8) else {
            throw JsonDetailError.failedToDecoder
        }
        return try JSONDecoder().decode([Book].self, from: jsonData)
    }
    
    func decodeLivro(jsonString: String) throws -> [BookResume] {
          
           guard let jsonData = jsonString.data(using: .utf8) else {
               throw JsonDetailError.failedToDecoder
           }
        
          return try JSONDecoder().decode([BookResume].self, from: jsonData)
    }
}
