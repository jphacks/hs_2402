//
//  ActionEditView.swift
//  Tripper
//
//  Created by 森田匠 on 2024/10/26.
//

import SwiftUI

struct ActionEditView: View {
    @Binding var trip: Trip
    @State var action: Action

    @State private var name: String = ""
    @State private var category: Category = .activity(.dining)
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date()
    @State private var memo: String = ""

    @State private var isValidCategory: Bool = true
    @State private var isValidEndTime: Bool = true
    @State private var isValidMemo: Bool = false
    @Environment(\.dismiss) var dismiss

    init(trip: Binding<Trip>, action: Action) {
        self._trip = trip
        self.action = action
        self._name = State(initialValue: action.title)
        self._category = State(initialValue: action.category)
        self._startTime = State(initialValue: action.startTime)
        if action.endTime != nil {
            self._endTime = State(initialValue: action.endTime!)}
        if action.memo != nil {
            self._memo = State(initialValue: action.memo!)}


    }

    var body: some View {
        Form {
            Section(header: Text("イベント")) {
                HStack {
                    Text("イベント")
                    TextField("タイトルを入力", text: $name)
                        .multilineTextAlignment(TextAlignment.trailing)
                }

                HStack(alignment: .top) {
                    Text("カテゴリ")
                        .padding(.top, 4)
                    Spacer()
                    VStack {
                        Picker("", selection: $category) {
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
                        .pickerStyle(MenuPickerStyle())
                    }
                }
            }

            DatePicker("開始時刻", selection: $startTime, in: ...endTime, displayedComponents: .hourAndMinute)
            HStack(alignment: .top, spacing: 0) {
                Text("終了時刻")
                    .padding(.top, 4)
                Spacer()
                VStack {
                    if isValidEndTime {
                        DatePicker("", selection: $endTime, in: startTime..., displayedComponents: .hourAndMinute)
                    }
                    Toggle(isOn: $isValidEndTime, label: {})
                }
            }

            Section {
                HStack {
                    Text("メモ")
                    Spacer()
                    Toggle(isOn: $isValidMemo){}
                }
                if isValidMemo {
                    TextEditor(text: $memo)
                        .listRowInsets(EdgeInsets())
                        .padding(.horizontal, 16)
                        .frame(height: 100)
                }
            }

            Button(action: replaceTrip) {
                Text("イベントを追加")
                    .foregroundColor(Color.white)
                    .bold()
            }
            .hAlign(.center)
            .vAlign(.center)
            .background(Color.blue)
            .listRowInsets(EdgeInsets())
            .navigationTitle("新規イベント")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    func replaceTrip() {
        var addingEndTime: Date? = self.endTime
        var addingMemo: String? = self.memo
        var index: Int?

        if !isValidEndTime {
            addingEndTime = nil
        }
        if !isValidMemo {
            addingMemo = nil
        }

        let updateAction = Action(id: action.id, title: name, category: category, startTime: startTime, endTime: addingEndTime, memo: addingMemo)
        for i in 0..<trip.actions.count {
            if trip.actions[i].id == updateAction.id{
                index = i
            }
        }
        if index != nil {
            trip.actions[index!]=updateAction
        }
        dismiss()
    }
}

//#Preview {
//    @Previewable @State var trip = mockTrip
//    //@Previewable  var index = 0
//    ActionEditView(trip: trip, id: Binding<>)
//}
