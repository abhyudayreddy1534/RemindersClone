//
//  MyListView.swift
//  RemindersClone
//
//  Created by Sravanthi Chinthireddy on 06/05/24.
//

import SwiftUI

struct MyListView: View {
    
    let myList: FetchedResults<MyList>
    
    var body: some View {
        NavigationStack {
            if myList.isEmpty {
                Spacer()
                Text("Nothing Yet!!!")
            }
            else {
                ForEach(myList) { list in
                    NavigationLink(value: list) {
                        VStack {
                            MyListItemView(myList: list)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)
                            Divider()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationDestination(for: MyList.self) { list in
                    MyListDetailView(myList: list)
                        .navigationTitle(list.name)
                }
            }
        }
    }
}

//#Preview {
//    MyListView()
//}
