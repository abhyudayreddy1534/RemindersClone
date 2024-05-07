//
//  ReminderStatsBuilder.swift
//  RemindersClone
//
//  Created by Sravanthi Chinthireddy on 07/05/24.
//

import Foundation
import SwiftUI

struct ReminderStatsValues {
    var todayCount: Int = 0
    var scheduledCount: Int = 0
    var allCount: Int = 0
    var completedCount: Int = 0
}

struct ReminderStatsBuilder {
    func build(myListResults: FetchedResults<MyList>) -> ReminderStatsValues{
        let remindersArray = myListResults.map{
            $0.remindersArray
        }.reduce([], +)
        
        let allCount = calculateAllCount(reminders: remindersArray)
        let completedCount = calculateCompletedCount(reminders: remindersArray)
        let todayCount = calculateTodaysCount(reminders: remindersArray)
        let scheduledCount = calculateScheduledCount(reminders: remindersArray)
        
        return ReminderStatsValues(
            todayCount: todayCount,
            scheduledCount: scheduledCount,
            allCount: allCount,
            completedCount: completedCount
        )
    }
    
    private func calculateAllCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { partialResult, reminder in
            return !reminder.isCompleted ? partialResult + 1 : partialResult
        }
    }
    
    private func calculateCompletedCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { partialResult, reminder in
            return reminder.isCompleted ? partialResult + 1 : partialResult
        }
    }
    
    private func calculateTodaysCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { partialResult, reminder in
            let isToday = reminder.reminderDate?.isToday ?? false
            return isToday ? partialResult + 1 : partialResult
        }
    }
    
    private func calculateScheduledCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { partialResult, reminder in
            return (
                (reminder.reminderDate != nil || reminder.reminderTime != nil) && !reminder.isCompleted
            ) ? partialResult + 1 : partialResult
        }
    }
}
