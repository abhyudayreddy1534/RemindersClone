//
//  MyListItemView.swift
//  RemindersClone
//
//  Created by Sravanthi Chinthireddy on 06/05/24.
//

import SwiftUI

struct MyListItemView: View {
    
    let myList: MyList
    
    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal.circle.fill")
                .font(.system(size: 50))
                .foregroundStyle(Color(myList.color ?? .black))
            Text(myList.name)
                .font(.title2)
                .fontWeight(.medium)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
                .padding(.trailing, 10)
        }
    }
}

#Preview {
    MyListItemView(myList: PreviewData.myList)
}
