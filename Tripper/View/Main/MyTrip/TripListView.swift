//
//  SelectTravelCourseView.swift
//  CreatePlan
//
//  Created by 森田匠 on 2024/10/24.
//

import SwiftUI

struct TripListView: View {
    @Binding var trips: [Trip]
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(trips.indices, id: \.self) { index in
                    NavigationLink {
                        TripDetailView(trip: $trips[index])
                    } label: {
                        TripRowView(trip: trips[index])
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var trips: [Trip] = [mockTrip]
    TripListView(trips: $trips)
}
