//
//  InputSchedule.swift
//  CreatePlan
//
//  Created by 森田匠 on 2024/10/23.
//

import SwiftUI

struct InputActionView: View {
    @State private var name: String = ""
    @State private var startTime: Date = Date()
    @State private var eneTime: Date? = nil
    @State private var starttimeh: String = ""
    @State private var starttimem: String = ""
    @State private var endtimeh: String = ""
    @State private var endtimem: String = ""
    @State private var category: Category = .activity(.sightseeing)
    @State private var memo: String = ""
    @State private var adress: String = ""
    @State private var imageUrl: String = ""

    @Binding var trip: Trip

    @Environment(\.dismiss) var dismiss

    var body: some View {
        Form {
            HStack{
                Text("イベント: ")
                Spacer()
                TextField("イベント名", text: $name)
            }

            HStack {
                Text("開始時刻: ")
                TextField("00", text: $starttimeh)
                    .keyboardType(.numberPad)  // 数字入力用キーボード
                Text("時")
                TextField("00", text: $starttimem)
                    .keyboardType(.numberPad)  // 数字入力用キーボード
                Text("分")
                Spacer()
            }

            HStack {
                Text("終了時刻: ")
                TextField("00", text: $endtimeh)
                    .keyboardType(.numberPad)  // 数字入力用キーボード
                Text("時")
                TextField("00", text: $endtimem)
                    .keyboardType(.numberPad)  // 数字入力用キーボード
                Text("分")
                Spacer()
            }

            HStack {
                Text("場所: ")
                Spacer()
                TextField("住所", text: $adress)
            }

            Picker("カテゴリを選択", selection: $category) {
                // Activityカテゴリの選択肢
                ForEach(Activity.allCases, id: \.self) { activity in
                    HStack {
                        Image(systemName: activity.image())
                        Text(activity.rawValue)
                    }
                    .tag(Category.activity(activity))
                }

                // Transportカテゴリの選択肢
                ForEach(Transport.allCases, id: \.self) { transport in
                    HStack {
                        Image(systemName: transport.image())
                        Text(transport.rawValue)
                    }
                    .tag(Category.transport(transport))
                }
            }
            .tint(.black)
            .pickerStyle(MenuPickerStyle())

            HStack {
                Text("メモ: ")
                TextField("何する？", text: $memo)
            }

            HStack {
                Spacer()  // 左に空白を作る
                Button(action: {dismiss()}) {
                    Text("プランを追加")
                        .foregroundColor(Color.blue)
                }
            }
            .padding()
            .navigationTitle("新規プラン")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    @Previewable @State var trip = mockTrip
    InputActionView(trip: $trip)
}
