//
//  CoreDataProvider.swift
//  HelloBudget
//
//  Created by Amin Siddiqui on 07/04/23.
//

import CoreData

class CoreDataProvider {
    
    static let shared = CoreDataProvider()
    
    let persistentContainer: NSPersistentContainer
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "BudgetModel")
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError(error.localizedDescription)
            }
        }
    }
}
