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
        HStack(alignment: .center, spacing: 24) {
            Image(systemName: action.category.image())
                .font(.largeTitle)
                .frame(width: 30, height: 30)
                .foregroundStyle(.mint)
                .padding(.vertical, 24)

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 4) {
                    Text(action.startTime.formatted(.dateTime.hour().minute()))
                    if let endTime = action.endTime {
                        Text("-")
                        Text(endTime.formatted(.dateTime.hour().minute()))
                    }
                }
                .foregroundStyle(.secondary)
                .font(.callout)

                Text(action.title)
                    .font(.title3)
            }
        }
        .hAlign(.leading)
    }
}

#Preview {
    ActionRowView(action: mockActions[1])
        .padding(.horizontal, 24)
        .background(Color(UIColor.systemGray6))
}
