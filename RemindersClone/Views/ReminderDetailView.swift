//
//  ReminderDetailView.swift
//  RemindersClone
//
//  Created by Sravanthi Chinthireddy on 07/05/24.
//

import SwiftUI

struct ReminderDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var reminder: Reminder
    @State var editConfig: ReminderEditConfig = ReminderEditConfig()
    
    private var isFormValid: Bool {
        !editConfig.title.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Title", text: $editConfig.title)
                        TextField("Notes", text: $editConfig.notes ?? "")
                    }
                    
                    Section {
                        Toggle(isOn: $editConfig.hasDate) {
                            Image(systemName: "calendar")
                                .foregroundStyle(.red)
                        }
                        
                        if editConfig.hasDate {
                            DatePicker("Select Date", selection: $editConfig.reminderDate ?? Date(), displayedComponents: .date)
                        }
                        
                        Toggle(isOn: $editConfig.hasTime, label: {
                            Image(systemName: "clock")
                                .foregroundStyle(.blue)
                        })
                        
                        if editConfig.hasTime {
                            DatePicker("Select Time", selection: $editConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
                        }
                    }
                    
                    Section {
                        NavigationLink {
                            SelectListView(selectedList: $reminder.list)
                        } label: {
                            HStack {
                                Text("List")
                                Spacer()
                                Text(reminder.list!.name)
                            }
                        }
                    }
                }
                .onChange(of: editConfig.hasDate) { hasDate in
                    if hasDate {
                        editConfig.reminderDate = Date()
                    }
                }
                .onChange(of: editConfig.hasTime) { hasTime in
                    if hasTime {
                        editConfig.reminderTime = Date()
                    }
                }
            }
            .onAppear(perform: {
                editConfig = ReminderEditConfig(with: reminder)
            })
            .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    Text("Details")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        if isFormValid {
                            do {
                                let _ = try ReminderService.updateReminder(
                                    reminder: reminder,
                                    editConfig: editConfig
                                )
                            }
                            catch {
                                print(error)
                            }
                            dismiss()
                        }
                    }
                    .disabled(!isFormValid)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            })
        }
    }
}

#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder))
}
