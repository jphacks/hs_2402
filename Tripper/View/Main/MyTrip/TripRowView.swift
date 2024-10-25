//
//  TripRowView.swift
//  Tripper
//
//  Created by 森祐樹 on 2024/10/25.
//

import SwiftUI

struct TripRowView: View {
    var trip: Trip
    var body: some View {
        VStack(alignment: .leading) {
            Text(trip.title)
                .lineLimit(1)
                .foregroundColor(.primary)
            Text("♡\(trip.likes)")
                .font(.footnote)
                .lineLimit(1)
                .foregroundColor(.secondary)
        }
        .hAlign(.leading)
        .padding()
    }
}

#Preview {
    TripRowView(trip: mockTrip)
}
