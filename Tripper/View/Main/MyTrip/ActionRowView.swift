//
//  PlanRow.swift
//  CreatePlan
//
//  Created by 森田匠 on 2024/10/23.
//

import SwiftUI

struct ActionRowView: View {
    let action: Action
    var body: some View {
        HStack(spacing: 16) {
            VStack {
                Text(action.startTime.formatted(.dateTime.hour().minute()))
                Text("|")
                Text(action.endTime?.formatted(.dateTime.hour().minute()) ?? "")
            }
            .padding()
            .background(.white)
            .cornerRadius(20)

            if let image = action.category?.image() {
                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 35, height: 35)
            }

            Text(action.name)
        }
        .hAlign(.leading)
        .padding()
        .background(.blue)
        .cornerRadius(20)
    }
}

#Preview {
    ActionRowView(action: mockSchedules.first!)
}
