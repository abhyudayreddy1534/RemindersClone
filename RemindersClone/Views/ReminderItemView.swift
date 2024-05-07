//
//  ReminderItemVIew.swift
//  RemindersClone
//
//  Created by Sravanthi Chinthireddy on 07/05/24.
//

import SwiftUI

enum ReminderItemEvents {
    case onInfo
    case onCheckChange(Reminder, checked: Bool)
    case onItemSelect(Reminder)
}

struct ReminderItemView: View {
    
    let reminder: Reminder
    let delay = Delay()
    let isItemSelected: Bool
    @State private var checked: Bool = false
    
    let onEvent: (ReminderItemEvents) -> Void
    
    private func formattedDate(_ date: Date) -> String {
        if date.isToday {
            return "Today"
        }
        else if date.isTomorrow {
            return "Tomorrow"
        }
        else {
            return date.formatted(date: .numeric, time: .omitted)
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: checked ? "circle.inset.filled" : "circle")
                .font(.title2)
                .opacity(0.4)
                .onTapGesture {
                    checked.toggle()
//                    cancel saving DONE for reminder just like iOS default
                    delay.cancel()
                    
//                    save it
                    delay.performWork {
                        onEvent(.onCheckChange(reminder, checked: checked))
                    }
                    
                }
            
            VStack(alignment: .leading) {
                Text(reminder.title ?? "")
                if let notes = reminder.notes, !notes.isEmpty {
                    Text(notes)
                        .opacity(0.4)
                        .font(.caption)
                }
                
                HStack {
                    if let reminderDate = reminder.reminderDate {
                        Text(formattedDate(reminderDate))
                    }
                    
                    if let reminderTime = reminder.reminderTime {
                        Text(reminderTime.formatted(date: .omitted, time: .shortened))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .opacity(0.4)
            }
            
            Image(systemName: "info.circle.fill")
                .opacity(isItemSelected ? 1.0 : 0)
                .onTapGesture {
                    onEvent(.onInfo)
                }
        }
        .onAppear(perform: {
            checked = reminder.isCompleted
        })
        .contentShape(Rectangle())
        .onTapGesture {
            onEvent(.onItemSelect(reminder))
        }
    }
}

#Preview {
    ReminderItemView(reminder: PreviewData.reminder, isItemSelected: false, onEvent: {_ in})
}
