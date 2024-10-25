//
//  SelectTravelCourseView.swift
//  CreatePlan
//
//  Created by 森田匠 on 2024/10/24.
//

import SwiftUI

struct TripListView: View {
    @EnvironmentObject var pvm:TripViewModel

    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(pvm.travelcourse){ travelcourse in
                    NavigationLink{
                        TripDetailView()
                    } label: {
                        TripRowView(trip: travelcourse)
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var pvm: TripViewModel = TripViewModel()
    TripListView()
        .environmentObject(pvm)
}
