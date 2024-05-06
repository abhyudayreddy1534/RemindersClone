//
//  CoreDataProvider.swift
//  RemindersClone
//
//  Created by Sravanthi Chinthireddy on 06/05/24.
//

import Foundation
import CoreData

struct CoreDataProvider {
    static let shared = CoreDataProvider()
    let persistentContainer: NSPersistentContainer
    
    private init() {
//        register the transformer
        ValueTransformer.setValueTransformer(
            UIColorTransformer(),
            forName: NSValueTransformerName("UIColorTransformer")
        )
        
        persistentContainer = NSPersistentContainer(name: "RemindersModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Error initialising RemindersModel \(error)")
            }
        }
    }
}
