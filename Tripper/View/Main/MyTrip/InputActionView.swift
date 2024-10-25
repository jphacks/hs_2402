//
//  InputSchedule.swift
//  CreatePlan
//
//  Created by 森田匠 on 2024/10/23.
//

import SwiftUI

struct InputActionView: View {
    @State private var name: String = ""
    @State private var starttimeh: String = ""
    @State private var starttimem: String = ""
    @State private var endtimeh: String = ""
    @State private var endtimem: String = ""
    @State private var category: Category = .activity(.sightseeing)
    @State private var categoryString: String = ""
    @State private var memo: String = ""
    @State private var adress: String = ""
    @State private var imageUrl: String = ""
    
    @EnvironmentObject var pvm:TripViewModel //= PlanViewModel()
    @State private var isShowCreate:Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Form{
                Button("取り消し") {
                                // 一つ前の画面に戻る
                                presentationMode.wrappedValue.dismiss()
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                
                HStack{
                    Spacer()
                    Text("イベント: ")
                    TextField("イベント名", text: $name)
                    Spacer()
                }
                HStack
                {
                    Spacer()
                    Text("開始時刻: ")
                    TextField("00", text: $starttimeh)
                        .keyboardType(.numberPad)  // 数字入力用キーボード
                    Text("時")
                    TextField("00", text: $starttimem)
                        .keyboardType(.numberPad)  // 数字入力用キーボード
                    Text("分")
                    Spacer()
                }
                
                HStack
                {
                    Spacer()
                    Text("終了時刻: ")
                    TextField("00", text: $endtimeh)
                        .keyboardType(.numberPad)  // 数字入力用キーボード
                    Text("時")
                    TextField("00", text: $endtimem)
                        .keyboardType(.numberPad)  // 数字入力用キーボード
                    Text("分")
                    Spacer()
                }
                
                
                
                HStack{
                    Spacer()
                    Text("場所: ")
                    TextField("住所", text: $adress)
                    Spacer()
                }
                
                HStack{
                    Spacer()
                    //Text("場所の種類:\(categoryString)")
                    Picker("場所の種類:",selection: $categoryString) {
                        /// 選択項目の一覧
                        Text("食事").tag("食事")
                        Text("買い物").tag("買い物")
                        Text("体験").tag("体験")
                        Text("観光").tag("観光")
                    }
                    Spacer()
                }
                
                HStack{
                    Spacer()
                    Text("メモ: ")
                    TextField("何する？", text: $memo)
                    Spacer()
                }
                
                //Spacer()  // 上に空白を作る
                HStack {
                    Spacer()  // 左に空白を作る
                    //プラン追加用ボタン
                    //inputArea
                    Button(action: {
                        //print(pvm.travelcourse[0].spots)
                        pvm.addSchedule(
                                        name: name,
                                        category: category,
                                        memo: memo,
                                        address: adress,
                                        imageurl: imageUrl,
                                        starttime: pvm.starttime(starttimeh: starttimeh, starttimem: starttimem),
                                        endtime: pvm.endtime(endtimeh: endtimeh, endtimem: endtimem))
                        print("プラン追加！")
                        isShowCreate = true  // 処理後、フラグをtrueにする
                        dismiss()
                                    }) {
                                        Text("プランを追加")
                                            .foregroundColor(Color.blue)
                                    }
                    // フラグがtrueの時に遷移する
//                                    NavigationLink(
//                                        destination: CreatePlanView()
//                                            .environmentObject(pvm)
//                                            .toolbar(.hidden),
//                                        isActive: $isShowCreate
//                                    ) {
//                                        EmptyView()  // 空のビューを使用
//                                    }
                }
                .padding()
            }

        }
    }
    
}

//#Preview {
//    InputScheduleView()
//}

extension InputActionView{
    private var inputArea: some View{
        NavigationLink(destination: TripDetailView()
            .environmentObject(pvm)
            .toolbar(.hidden)) {
                Text("プランを追加")
                    .foregroundColor(Color.blue)
        }
    }
}
