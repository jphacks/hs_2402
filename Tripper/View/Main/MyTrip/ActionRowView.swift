//
//  PlanRow.swift
//  CreatePlan
//
//  Created by 森田匠 on 2024/10/23.
//

import SwiftUI

struct ActionRowView: View {
    let action: Action
    @ObservedObject var pvm: TripViewModel = TripViewModel()

    var body: some View {

        HStack {
            VStack {
                Text(pvm.formattedStartTime(date: action.startTime))
                Text("|")
                Text(pvm.formattedStartTime(date: action.endTime))
            }
            .padding()
            .background(.white)
            .cornerRadius(20)
            
            //Image(systemName: "fork.knife")
            //Text(schedule.imageUrl ?? "")
            
            VStack {
                if let url = URL(string: action.imageUrl ?? "") {
                           AsyncImage(url: url) { phase in
                               switch phase {
                               case .empty:
                                   ProgressView()  // 画像がロードされるまでのインジケーター
                               case .success(let image):
                                   image
                                       .resizable()
                                       .aspectRatio(contentMode: .fit)  // 画像を表示する際の調整
                                       .frame(width: 200, height: 200)  // 画像のサイズを指定
                               case .failure:
                                   Image(systemName: "exclamationmark.triangle.fill")  // エラー時のアイコン
                                       .resizable()
                                       .frame(width: 50, height: 50)
                               @unknown default:
                                   EmptyView()
                               }
                           }
                       } else {
                           Text("Invalid URL")  // URLが無効な場合に表示されるテキスト
                       }
                   }
            
            
            Text(action.name)
        }
        .padding()
        .background(.blue)
        .cornerRadius(20)
    }
}

//#Preview {
//    PlanRow()
//}
