//
//  TestCoreDataStack.swift
//  ApplicationTests
//
//  Created by Lidiane Gomes Barbosa on 05/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
// swiftlint:disable all

import CoreData
@testable import tempo_com_Deus
class TestCoreDataStack {
    static let shared = TestCoreDataStack()
    let persistentStoreDescription: NSPersistentStoreDescription
    let testPersistentContainer: NSPersistentContainer
    let viewContext: NSManagedObjectContext
    
    init() {
        self.persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        self.testPersistentContainer = NSPersistentContainer(name: "NoteDataModel")
        testPersistentContainer.persistentStoreDescriptions = [persistentStoreDescription]
        testPersistentContainer.loadPersistentStores { (_, error: Error?) in
                  if let _ = error {
                      fatalError()
                  }
              }
        
        self.viewContext = testPersistentContainer.viewContext
    }
}
