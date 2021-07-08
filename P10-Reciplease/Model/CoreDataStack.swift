//
//  CoreDataStack.swift
//  P10-Reciplease
//
//  Created by vincent on 24/06/2021.
//

import Foundation
import CoreData


open class CoreDataStack {
    
    
    private let modelName: String
    
    
    
    public init(modelName: String) {
        self.modelName = modelName
    }
    
    
    public lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    public lazy var mainContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    public func saveContext() {
        guard mainContext.hasChanges else { return }
        do {
            try mainContext.save()
        } catch let error as NSError {
            print("error \(error), \(error.userInfo)")
        }
    }
}
