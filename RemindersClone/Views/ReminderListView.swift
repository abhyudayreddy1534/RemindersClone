//
//  ReminderListView.swift
//  RemindersClone
//
//  Created by Sravanthi Chinthireddy on 06/05/24.
//

import SwiftUI

struct ReminderListView: View {
    let reminders: FetchedResults<Reminder>
    
    var body: some View {
        List(reminders, id: \.self) {reminderItem in
//            print(reminderItem.title)
            Text(reminderItem.title ?? "---")
        }
    }
}

//#Preview {
//    ReminderListView()
//}
