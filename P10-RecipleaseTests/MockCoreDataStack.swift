//
//  MockCoreDataStack.swift
//  P10-RecipleaseTests
//
//  Created by vincent on 30/06/2021.
//

import P10_Reciplease
import Foundation
import CoreData

final class MockCoreDataStack: CoreDataStack {
    
    convenience init() {
        self.init(modelName: "P10_Reciplease")
    }
    
    override init(modelName: String) {
        super.init(modelName: modelName)
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.persistentContainer = container
    }
    
}
