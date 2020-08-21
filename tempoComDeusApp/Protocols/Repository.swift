//
//  Repository.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 17/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
protocol Repository: class {
      associatedtype Item: Nota
      
      var items: [Item] { get set }
      
    func createNewItem(body: String, cor: String)
      func readAllItems() -> [Item]
      func readItem(itemId: UUID) -> Item?
      func update(item: Item)
      func delete(itemId: UUID)
    
}

extension Repository {
    
    func createNewItem(body: String, cor: String) {
        let newItem = Item()
        newItem.cor = cor
        newItem.body = body
        if let data = try? JSONEncoder().encode(newItem) {
            FileHelper().createFile(with: data, name: newItem.notaId.uuidString)
        }
    }
    
    func readAllItems() -> [Item] {
        let fileNames: [String] = FileHelper().contentsForDirectory(atPath: "")
        self.items = fileNames.compactMap { fileName in
            if let data = FileHelper().retrieveFile(at: fileName) {
                let item = try? JSONDecoder().decode(Item.self, from: data)
                return item
            }
            return nil
        }
        
        return items.sorted { (item1, item2) -> Bool in
            item1.date > item2.date
        }
    }
    
    func readItem(itemId: UUID) -> Item? {
        if let data = FileHelper().retrieveFile(at: itemId.uuidString) {
            let item = try? JSONDecoder().decode(Item.self, from: data)
            return item
        }
        return nil
    }
    
    func update(item: Item) {
        if let data = try? JSONEncoder().encode(item) {
            FileHelper().updateFile(at: item.notaId.uuidString, data: data)
        }
    }
    
    func delete(itemId: UUID) {
        FileHelper().removeFile(at: itemId.uuidString)
    }
    
}
