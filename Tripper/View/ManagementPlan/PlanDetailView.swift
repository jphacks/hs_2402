//
//  PlanDetailView.swift
//  CreatePlan
//
//  Created by 森田匠 on 2024/10/22.
//

import SwiftUI

struct PlanDetailView: View {
    var body: some View {
        let mockTravelCourse = mockTravelCourse
        let mockSchedules0 = mockTravelCourse.spots[0]//スケジュールのモックデータの1つ目を格納
        
        func formattedStartTime(date: Date?) -> String {
            let dateFormatter = DateFormatter()
            
            //dateFormatter.dateStyle = .medium    // 日付フォーマットを設定
            dateFormatter.timeStyle = .short  // 時間のみ表示
            
            // dateがnilの場合、デフォルトの文字列を返す
            if let validDate = date {
                return dateFormatter.string(from: validDate)
            } else {
                return "未定"  // nil の場合に返すデフォルトメッセージ
            }
        }

        
        return VStack {
            HStack{
                VStack{
                    Text(formattedStartTime(date: mockSchedules0.startTime))
                    Text("|")
                    Text(formattedStartTime(date: mockSchedules0.endTime))
                }
                .padding()
                .background(.white)
                .cornerRadius(20)
                
                Image(systemName: "fork.knife")
                Text("レストラン")
            }
            .padding()
            .background(.blue)
            .cornerRadius(20)
            
//            HStack{
//                Image(systemName: "arrowshape.down")
//                    .imageScale(.large)
//                Image(systemName: "car")
//                    .imageScale(.large)
//                Text("10分")
//
//            }
        }
    }

}

#Preview {
    PlanDetailView()
}
