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
      
    func createNewItem(body:String) -> Item?
      func readAllItems() -> [Item]
      func readItem(id: UUID) -> Item?
      func update(item: Item)
      func delete(id: UUID)
    
}

extension Repository {
    
    func createNewItem(body: String) -> Item? {
        let newItem = Item(body: body)
        if let data = try? JSONEncoder().encode(newItem) {
            FileHelper().createFile(with: data, name: newItem.id.uuidString)
            return newItem
        }

        return nil
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
        
        return items
    }
    
    func readItem(id: UUID) -> Item? {
        if let data = FileHelper().retrieveFile(at: id.uuidString) {
            let item = try? JSONDecoder().decode(Item.self, from: data)
            return item
        }
        return nil
    }
    
    func update(item: Item) {
        if let data = try? JSONEncoder().encode(item) {
            FileHelper().updateFile(at: item.id.uuidString, data: data)
        }
    }
    
    func delete(id: UUID) {
        FileHelper().removeFile(at: id.uuidString)
    }
    
}
