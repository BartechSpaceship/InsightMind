//
//  PersistenceService.swift
//  InsightMind
//
//  Created by Bartek on 4/13/20.
//  Copyright © 2020 Bartek. All rights reserved.
//

import Foundation
import CoreData

class PersistanceService {

    // MARK: - Core Data stack

    private init() {}
    //container that we plan on saving stuff into "Context"
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "InsightMind")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
