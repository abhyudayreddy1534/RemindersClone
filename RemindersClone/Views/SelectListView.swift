//
//  SelectListView.swift
//  RemindersClone
//
//  Created by Sravanthi Chinthireddy on 07/05/24.
//

import SwiftUI

struct SelectListView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListFetchedFResults: FetchedResults<MyList>
    @Binding var selectedList: MyList?
    
    var body: some View {
        List(myListFetchedFResults) { myList in
            HStack {
                Image(systemName: "line.3.horizontal.circle.fill")
                    .foregroundStyle(Color(myList.color!))
                Text(myList.name)
                Spacer()
                if selectedList == myList {
                    Image(systemName: "checkmark")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .onTapGesture {
                self.selectedList = myList
            }
        }
    }
}

#Preview {
    SelectListView(selectedList: .constant(PreviewData.myList))
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
