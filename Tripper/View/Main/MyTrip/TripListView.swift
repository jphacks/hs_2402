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
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(trips.indices, id: \.self) { index in
                    NavigationLink {
                        TripDetailView(trip: $trips[index], trips: $trips)
                    } label: {
                        TripRowView(trip: trips[index])
                    }
                    Divider()
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var trips: [Trip] = [mockTrip, mockTrip2]
    TripListView(trips: $trips)
}
