//
//  MyListDetailView.swift
//  RemindersClone
//
//  Created by Sravanthi Chinthireddy on 06/05/24.
//

import SwiftUI

struct MyListDetailView: View {
    let myList: MyList
    @State private var openAddReminder: Bool =  false
    @State private var title: String = ""
    
    @FetchRequest(sortDescriptors: [])
    private var reminderResults: FetchedResults<Reminder>
    
    private var isFormValid: Bool {
        return !title.isEmpty
    }
    
    init(myList: MyList ) {
        self.myList = myList
        _reminderResults = FetchRequest(fetchRequest: ReminderService.getRemindersByList(myList: myList))
    }
    
    var body: some View {
        VStack {
            
//            Display the reminders list here
            
//            myList.reminders
            ReminderListView(reminders: reminderResults)
            
            HStack {
                Button {
                    openAddReminder = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                    Text("New Reminder")
                }

            }
            .foregroundStyle(.blue)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
        }
        .alert("New Reminder", isPresented: $openAddReminder) {
            TextField("Reminder", text: $title)
            Button("Cancel", role: .cancel) {}
            Button("Done") {
//                save the reminder
                do {
                    try ReminderService.saveReminderToMyList(
                        myList: myList,
                        title: title
                    )
                }
                catch {
                    print(error)
                }
            }
                .disabled(!isFormValid)
        } message: {
            Text("Please provide reminder details")
        }

    }
}

#Preview {
    MyListDetailView(myList: PreviewData.myList)
}
