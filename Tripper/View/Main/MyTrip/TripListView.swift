//
//  SelectTravelCourseView.swift
//  CreatePlan
//
//  Created by 森田匠 on 2024/10/24.
//

import SwiftUI

struct TripListView: View {
    @EnvironmentObject var pvm:PlanViewModel

    var body: some View {
        ScrollView{
            VStack{
                ForEach(pvm.travelcourse){ travelcourse in
                    NavigationLink{
                        TripDetailView()
                            .environmentObject(pvm)
                            .toolbar(.hidden)
                    } label: {
                        TripRowView(travelcourse: travelcourse)
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var pvm: PlanViewModel = PlanViewModel()
    TripListView()
        .environmentObject(pvm)
}

extension TripListView{
    private func TripRowView(travelcourse: Trip) -> some View {
        HStack{
            VStack(alignment: .leading){
                Text(travelcourse.title)
                    .lineLimit(1)
                    .foregroundColor(.primary)
                Text("♡\(String(travelcourse.likes))")
                    .font(.footnote)
                    .lineLimit(1)
                    .foregroundColor(Color(uiColor: .secondaryLabel))
            }
            .padding()
            Spacer()
        }
    }
}
