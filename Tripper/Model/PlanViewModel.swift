//
//  PlanViewModel.swift
//  CreatePlan
//
//  Created by 森田匠 on 2024/10/22.
//

import Foundation

class PlanViewModel: ObservableObject {
    @Published var travelcourse: [TravelCourse] = []
    @Published var isEditing: Bool = false

    init() {
        travelcourse.append(mockTravelCourse)// travelcourseの配列にモックデータを加える
    }

    func formattedStartTime(date: Date?) -> String {
        let dateFormatter = DateFormatter()

        // dateFormatter.dateStyle = .medium    // 日付フォーマットを設定
        dateFormatter.timeStyle = .short  // 時間のみ表示

        // dateがnilの場合、デフォルトの文字列を返す
        if let validDate = date {
            return dateFormatter.string(from: validDate)
        } else {
            return "未定"  // nil の場合に返すデフォルトメッセージ
        }
    }

    func  addTravelCourse(title: String, travelDate: Date, image: String?, prefecture: String?) {// 機能見直しの必要あり
        let spots: [Schedule] = []
        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let formattedDateString = formatter.string(from: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"  // フォーマットが正しく指定されていることを確認
        var dateFromString = dateFormatter.date(from: "2024/10/22")// 後々この部分を可変にする

        // dateFromStringがnilでないことを確認してから利用
        if let validDate = dateFromString {
            print("Date is \(validDate)")
        } else {
            print("Invalid date format")
            dateFromString=dateFormatter.date(from: "0000/00/00")
        }

//        let newMessage = Message(id: UUID().uuidString,
//                                 text: text,
//                                 user: User.currentUser,
//                                 date: formattedDateString,
//                                 readed: false
//        )

        let newTravelCourse = TravelCourse(
            // var id: String = UUID().uuidString         // 各コースの一意のID
            title: title,           // コースのタイトル
            travelDate: dateFromString!,     // 出発日
            // imageUrl: String?,         // 旅を表す写真のURL（オプション）
            // prefecture: String?, //JapanesePrefecture          // 主な目的地（都市や国など）
            spots: spots,             // 立ち寄るスポットのリスト
            likes: 0  // いいね数
        )

        travelcourse.append(newTravelCourse)
    }

    func addSchedule(name: String, category: Category?, memo: String?, address: String?, imageurl: String?,starttime: Date, endtime: Date) {// 機能見直しの必要あり
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"  // フォーマットが正しく指定されていることを確認
        var dateFromString = dateFormatter.date(from: "2024/10/22")// 後々この部分を可変にする

        // dateFromStringがnilでないことを確認してから利用
        if let validDate = dateFromString {
            print("Date is \(validDate)")
        } else {
            print("Invalid date format")
            dateFromString=dateFormatter.date(from: "0000/00/00")
        }
        
        
        let newSchedule = Schedule(
            name: name,             // スポットの名称
            category: category,
            memo: memo,       // スポットの説明orメモ
            address: address,           // スポットの住所
            imageUrl: imageurl,         // スポットの写真URL（オプション）
            startTime: starttime,
            endTime: endtime
        )
        
        travelcourse[0].spots.append(newSchedule)//ゆくゆくは0番目だけではなく、すべてのtravelcourseにアクセスできるようにする
    }
    
    func starttime(starttimeh: String, starttimem: String) -> Date
    {return Calendar.current.date(bySettingHour: Int(starttimeh)!, minute: Int(starttimem)!, second: 0, of: Date())!}
    func endtime(endtimeh: String, endtimem: String)-> Date
    {return Calendar.current.date(bySettingHour: Int(endtimeh)!, minute: Int(endtimem)!, second: 0, of: Date())!}

}
