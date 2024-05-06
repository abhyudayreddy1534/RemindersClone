//
//  AddNewListView.swift
//  RemindersClone
//
//  Created by Sravanthi Chinthireddy on 06/05/24.
//

import SwiftUI

struct AddNewListView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var selectedColor: Color = .yellow
    
    let onSave :(String, UIColor) -> Void
    
    private var isFormValid: Bool {
        return !name.isEmpty
    }
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "line.3.horizontal.circle.fill")
                    .foregroundStyle(selectedColor)
                    .font(.system(size: 100))
                TextField("List Name", text: $name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(30)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            
            ColorPickerView(selectedColor: $selectedColor)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar(content: {
            ToolbarItem(placement: .principal) {
                Text("New List")
                    .font(.headline)
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Close")
                })
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    
                    onSave(name, UIColor(selectedColor))
                    
                    dismiss()
                }, label: {
                    Text("Done")
                })
                .disabled(!isFormValid)
            }
        })
    }
}

#Preview {
    NavigationView(content: {
        AddNewListView(onSave: {(_, _) in })
    })
}
