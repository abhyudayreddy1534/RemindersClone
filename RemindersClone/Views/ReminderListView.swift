//
//  ReminderListView.swift
//  RemindersClone
//
//  Created by Sravanthi Chinthireddy on 06/05/24.
//

import SwiftUI

struct ReminderListView: View {
    let reminders: FetchedResults<Reminder>
    @State private var selectedReminder: Reminder?
    @State private var showReminderDetail: Bool = false
    
    private func reminderCheckedChanged(for reminder: Reminder, isCompleted: Bool) {
        var editConfig = ReminderEditConfig(with: reminder)
        editConfig.isCompleted = isCompleted
        
        do {
            let _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        }
        catch {
            print(error)
        }
    }
    
    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        selectedReminder?.objectID == reminder.objectID
    }
    
    private func deleteReminder(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let reminder = reminders[index]
            do {
                try ReminderService.deleteReminder(reminder: reminder)
            }
            catch{
                print(error)
            }
        }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(reminders, id: \.self) { reminderItem in
                    ReminderItemView(reminder: reminderItem, isItemSelected: isReminderSelected(reminderItem)) { event in
                        switch event {
                        case .onInfo:
                            print("info button tapped")
                            showReminderDetail = true
                        case .onCheckChange(let reminder, let isCompleted):
                            print("check tapped")
                            reminderCheckedChanged(for: reminder, isCompleted: isCompleted)
                        case .onItemSelect(let reminder):
                            print("whole row tapped")
                            selectedReminder = reminder
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    deleteReminder(indexSet)
                })
            }
        }
        .sheet(isPresented: $showReminderDetail, content: {
            ReminderDetailView(reminder: Binding($selectedReminder)!)
        })
    }
}

struct ReminderListView_Previews: PreviewProvider {
    
    struct Container: View {
        @FetchRequest(sortDescriptors: [])
        var reminderResults: FetchedResults<Reminder>
        var body: some View {
            ReminderListView(reminders: reminderResults)
        }
    }
    
    static var previews: some View {
        Container()
            .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
    }
}
