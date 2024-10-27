//
//  PrefectureTripListView.swift
//  Tripper
//
//  Created by 森祐樹 on 2024/10/26.
//

import SwiftUI

struct PrefectureTripListView: View {
    @State private var prefectureTrips: [Trip] = [mockTrip, mockTrip, mockTrip, mockTrip]
    let prefecture: Prefecture
    var body: some View {
        VStack {
            PrefectureCardView(prefecture: prefecture, cornerRadius: 0, height: 180)
                .shadow(radius: 2, y: 2)
            TripListView(trips: $prefectureTrips)
                .navigationTitle("\(prefecture.nameWithSuffix)のトリップ")
                .navigationBarTitleDisplayMode(.inline)
        }
        .vAlign(.top)
    }
}

#Preview {
    NavigationStack {
        PrefectureTripListView(prefecture: .tokushima)
    }
}
