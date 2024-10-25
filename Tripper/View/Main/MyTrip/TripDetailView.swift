//
//  CreatePlanView.swift
//  CreatePlan
//
//  Created by 森田匠 on 2024/10/22.
//

import SwiftUI

struct TripDetailView: View {
    @EnvironmentObject var pvm:PlanViewModel // = PlanViewModel()//この中にモックデータも入ってる
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationView {
            scrollArea
            .overlay(navigationArea, alignment: .top)
        }
    }
}
#Preview {
    @Previewable @StateObject var pvm: PlanViewModel = PlanViewModel()
    TripDetailView()
        .environmentObject(pvm)
}
extension TripDetailView{
    private var scrollArea: some View{
        ScrollView{
            VStack {
                    //プラン内容
                    planArea
                    // 右下に配置するプラスマークのボタン
                    Spacer()  // 上に空白を作る
                    HStack {
                        Spacer()  // 左に空白を作る
                        //プラン追加用ボタン
                        addPlanArea
                }
            }
        }
    }
    private var planArea: some View{
            ForEach(pvm.travelcourse[0].actions){spot in
                ActionRowView(action: spot)
            }
    }
    private var routeArea: some View{
        HStack{
            Image(systemName: "arrowshape.down")
                .imageScale(.large)
            Image(systemName: "car")
                .imageScale(.large)
            Text("10分")
        }
    }
    private var addPlanArea: some View{
        NavigationLink
        {
            InputActionView()
                .environmentObject(pvm)
                .toolbar(.hidden)
        }
        label:{
            Image(systemName: "plus")
                .font(.system(size: 30))  // プラスマークの大きさを指定
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .clipShape(Circle())  // ボタンを丸くする
                .shadow(radius: 10)  // ボタンに影を付ける
        }
        .padding()  // 右下に余白を追加
    }
    private var navigationArea: some View{
        Button
        {
            dismiss()
//            SelectTravelCourseView()
//                .environmentObject(pvm)
//                .toolbar(.hidden)
        }
        label:{
            HStack{
                Image(systemName: "chevron.backward")
                    .font(.system(size: 30))  // プラスマークの大きさを指定
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .clipShape(Circle())  // ボタンを丸くする
                    .shadow(radius: 10)  // ボタンに影を付ける
                Text(pvm.travelcourse[0].title)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
            .background(Color.blue.opacity(0.9))//opacity=透明度
        }
    }
}
