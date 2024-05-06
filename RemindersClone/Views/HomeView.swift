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
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
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
        }
        .padding()
    }
}

#Preview {
    HomeView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
