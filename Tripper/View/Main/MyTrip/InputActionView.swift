//
//  InputSchedule.swift
//  CreatePlan
//
//  Created by 森田匠 on 2024/10/23.
//

import SwiftUI

struct InputActionView: View {
    @State private var name: String = ""
    @State private var category: Category = .activity(.sightseeing)
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date()
    @State private var isValidEndTime: Bool = true
    @State private var memo: String = ""
    @State private var isValidMemo: Bool = false
    @Binding var trip: Trip
    @Environment(\.dismiss) var dismiss

    init(trip: Binding<Trip>) {
        self._trip = trip
        let calendar = Calendar.current
        let startTime = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: trip.wrappedValue.travelDate) ?? trip.wrappedValue.travelDate
        let endTime = calendar.date(bySettingHour: 23, minute: 0, second: 0, of: trip.wrappedValue.travelDate) ?? trip.wrappedValue.travelDate
        self._startTime = State(initialValue: startTime)
        self._endTime = State(initialValue: endTime)
    }

    var body: some View {
        Form {
            Section(header: Text("イベント")) {
                HStack {
                    Text("イベント")
                    TextField("タイトルを入力", text: $name)
                        .multilineTextAlignment(TextAlignment.trailing)
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
                .pickerStyle(MenuPickerStyle())
            }

            DatePicker("開始時刻", selection: $startTime, in: ...endTime, displayedComponents: .hourAndMinute)
            HStack(alignment: .top, spacing: 0) {
                Text("終了時刻")
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

            Button(action: addTrip) {
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

    func addTrip() {
        var addingMemo: String? = self.memo
        var addingEndTime: Date? = self.endTime
        if !isValidMemo {
            addingMemo = nil
        }
        if !isValidEndTime {
            addingEndTime = nil
        }
        let action = Action(name: name, category: category, startTime: startTime, endTime: addingEndTime, memo: addingMemo)
        trip.actions.append(action)
        trip.actions.sort { $0.startTime < $1.startTime }
        dismiss()
    }
}

#Preview {
    @Previewable @State var trip = mockTrip
    InputActionView(trip: $trip)
}
