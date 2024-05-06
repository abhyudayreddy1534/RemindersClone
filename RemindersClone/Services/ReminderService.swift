//
//  ReminderService.swift
//  RemindersClone
//
//  Created by Sravanthi Chinthireddy on 06/05/24.
//

import Foundation
import CoreData
import UIKit

class ReminderService {
    static var viewContext: NSManagedObjectContext {
        CoreDataProvider.shared.persistentContainer.viewContext
    }
    
    static func save() {
        do {
            try viewContext.save()
        }
        catch {
            print(error)
        }
    }
    
    static func saveMyList(_ name: String, _ color: UIColor) throws {
        let myList = MyList(context: viewContext)
        myList.name = name
        myList.color = color
        
        try save()
    }
    
    static func saveReminderToMyList(myList: MyList, title: String) throws {
        let reminder = Reminder(context: viewContext)
        reminder.title = title
        myList.addToReminders(reminder)
        try save()
    }
    
    static func getRemindersByList(myList: MyList) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "list = %@ AND isCompleted = false", myList)
        return request
    }

}
