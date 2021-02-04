//
//  File.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 02/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.

import Foundation

enum FileDetailError: Error {
    case failedToWriteFile
    case failedToReadFile
    case failedToCreateFile
}

extension FileDetailError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedToWriteFile:
            return NSLocalizedString("Error trying to write to the file", comment: "Decoder")
        case .failedToReadFile:
            return NSLocalizedString("Error trying to read file", comment: "Encoder")
        case .failedToCreateFile:
            return NSLocalizedString("Error trying to create file", comment: "CreateFile")
        }
    }
}

class File {
    
    func readFromFile(fileName: String) throws -> String? {
        var fileContent: String?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                fileContent = String(data: data, encoding: .utf8)
                
            } catch { throw FileDetailError.failedToReadFile }
        }
        return fileContent
    }
    
    func readBiblia() -> [Book] {
        var biblia: [Book] = []
        do {
            guard let bibliaString =
                try readFromFile(fileName: BIBLE) else { return [] }
            
            biblia = try Json().decodeBiblia(jsonString: bibliaString)
            
        } catch {
            print(error.localizedDescription)
        }
        return biblia
    }

    func readBibleByVersion(version: String) -> [BookResume] {
        var livros: [BookResume] = []
        do {
            guard let livrosString =
                try readFromFile(fileName: version) else { return [] }
            livros = try Json().decodeLivro(jsonString: livrosString)
        } catch {
            print(error.localizedDescription)
        }
        return livros
    }
}
