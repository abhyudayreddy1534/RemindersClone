//
//  ReminderStatsView.swift
//  RemindersClone
//
//  Created by Sravanthi Chinthireddy on 07/05/24.
//

import SwiftUI

struct ReminderStatsView: View {
    let icon: String
    let title: String
    let count: Int?
    var iconColor: Color = .blue
    let date: Int = Calendar.current.component(.day, from: Date())
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10, content: {
                    if title == "Today" {
                        #warning("A customisation to show calendar DAY")
                        ZStack {
                            Circle()
                                .fill(iconColor)
                            .frame(width: 50, height: 50)
                            RoundedRectangle(cornerRadius: 4)
                                .frame(width: 30, height: 30)
//                            Image(systemName: "calendar")
//                                .font(.title)
//                                .foregroundStyle(.white)
//                                .opacity(0.8)
//                            let a= date.get
                            Text("\(date)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .shadow(radius: 10)
                        }
                        
                    }
                    else {
                        Image(systemName: icon)
                            .foregroundStyle(iconColor)
                            .font(.title)
                    }
                    
                    Text(title)
                        .opacity(0.8)
                })
                Spacer()
                if let count {
                    Text("\(count)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.gray)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            
        }
    }
}

#Preview {
    ReminderStatsView(icon: "calendar", title: "Today", count: 3)
}
