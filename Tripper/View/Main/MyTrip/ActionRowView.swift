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
        HStack(alignment: .center, spacing: 16) {
            if let image = action.category?.image() {
                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.green)
                    .padding()
                    .background(Color.white)
                    .clipShape(Circle())
            } else {
                Circle()
                    .foregroundStyle(.white)
                    .frame(width: 30, height: 30)
                    .padding()
                    .background(Color.white)
                    .clipShape(Circle())
            }

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

                Text(action.name)
                    .font(.title3)
            }
        }
        .hAlign(.leading)
        .padding(.top)
    }
}

#Preview {
    ActionRowView(action: mockActions[1])
        .background(Color(UIColor.systemGray6))
}
