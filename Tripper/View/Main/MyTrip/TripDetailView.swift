//
//  CreatePlanView.swift
//  CreatePlan
//
//  Created by 森田匠 on 2024/10/22.
//

import SwiftUI

struct TripDetailView: View {
    @Binding var trip: Trip
    var body: some View {
        let _ = print(trip.actions)
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                // プラン内容
                ForEach(trip.actions){ action in
                    ActionRowView(action: action)
                    Divider()
                }
            }
            .padding(.horizontal, 24)
            .navigationTitle("\(trip.title)")
            .navigationBarTitleDisplayMode(.inline)
        }
        .hAlign(.center).vAlign(.top)
        .background(Color(UIColor.systemGray6))
        .overlay(alignment: .bottomTrailing) {
            AddActionButton
        }
    }
}

extension TripDetailView{
    private var AddActionButton: some View {
        NavigationLink {
            InputActionView(trip: $trip)
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 30))    // プラスマークの大きさを指定
                .foregroundColor(.white)
                .padding()
                .background(Color.black)
                .clipShape(Circle())        // ボタンを丸くする
                .shadow(radius: 10)         // ボタンに影を付ける
        }
        .padding()  // 右下に余白を追加
    }
}

#Preview {
    @Previewable @State var trip = mockTrip
    NavigationStack {
        TripDetailView(trip: $trip)
    }
}
