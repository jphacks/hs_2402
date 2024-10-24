//
//  SelectTravelCourseView.swift
//  CreatePlan
//
//  Created by 森田匠 on 2024/10/24.
//

import SwiftUI

struct SelectTravelCourseView: View {
    @EnvironmentObject var pvm:PlanViewModel
    
    var body: some View {
//        NavigationView {
        VStack{
            Text("コース一覧")
                .font(.title)
            
            ScrollView{
                VStack{
                    ForEach(pvm.travelcourse){ travelcourse in
                        NavigationLink{
                            CreatePlanView()
                                .environmentObject(pvm)
                                .toolbar(.hidden)
                        } label: {
                            travelCourseRow(travelcourse: travelcourse)
                            
                        }
                    }
                    }
                }
            }
//        }
    }
}

#Preview {
    @Previewable @StateObject var pvm: PlanViewModel = PlanViewModel()
    SelectTravelCourseView()
        .environmentObject(pvm)
}

extension SelectTravelCourseView{
    private func travelCourseRow(travelcourse: TravelCourse) -> some View {
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
