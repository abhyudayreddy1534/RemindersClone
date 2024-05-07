//
//  ContentView.swift
//  RemindersClone
//
//  Created by Sravanthi Chinthireddy on 06/05/24.
//

import SwiftUI

struct HomeView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    @FetchRequest(sortDescriptors: [])
    private var searchResults: FetchedResults<Reminder>
    
    @State private var isPresented: Bool = false
    @State private var search: String = ""
    @State private var searching: Bool = false
    
    private var reminderStatsBuilder = ReminderStatsBuilder()
    @State private var reminderStatsValues = ReminderStatsValues()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    HStack {
                        ReminderStatsView(
                            icon: "calendar",
                            title: "Today ",
                            count: reminderStatsValues.todayCount,
                            iconColor: .red
                        )
                        ReminderStatsView(
                            icon: "tray.circle.fill",
                            title: "All",
                            count: reminderStatsValues.allCount,
                            iconColor: .black
                        )
                    }
                    HStack {
                        ReminderStatsView(
                            icon: "calendar.circle.fill",
                            title: "Scheduled",
                            count: reminderStatsValues.scheduledCount,
                            iconColor: .red
                        )
                        ReminderStatsView(
                            icon: "checkmark.circle.fill",
                            title: "Completed",
                            count: reminderStatsValues.completedCount,
                            iconColor: .green
                        )
                    }
                    MyListView(myList: myListResults)
                    
                    Button(action: {
                        isPresented = true
                    }, label: {
                        Text("Add List")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.headline)
                    })
                    .padding()
                }
            }
            .listStyle(.plain)
            .onChange(of: search, perform: { searchTerm in
                searching = !searchTerm.isEmpty ? true : false
                searchResults.nsPredicate = ReminderService.getRemindersBySearchTerm(search: searchTerm).predicate
            })
            .overlay(alignment: .center, content: {
                ReminderListView(reminders: searchResults)
                    .opacity(searching ? 1.0 : 0.0)
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .sheet(isPresented: $isPresented, content: {
                NavigationView(content: {
                    AddNewListView { name, color in
//                        save data to DB
                        do {
                            try ReminderService.saveMyList(name, color)
                        }
                        catch {
                            print(error)
                        }
                    }
                })
            })
            .onAppear(perform: {
                reminderStatsValues = reminderStatsBuilder.build(myListResults: myListResults)
            })
            .padding()
            .navigationTitle("Reminders")
        }.searchable(text: $search)
    }
}

#Preview {
    HomeView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
