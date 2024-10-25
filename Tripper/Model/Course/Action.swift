//
//  Schedule.swift
//  TestTourApp
//
//  Created by 森祐樹 on 2024/10/17.
//

import Foundation

struct Action: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var category: Category?
    var startTime: Date
    var endTime: Date?
    var memo: String?
}

enum Category: Hashable {
    case activity(Activity)
    case transport(Transport)
    // 文字列でカテゴリー名を取得するヘルパーメソッド
    func description() -> String {
        switch self {
        case .activity(let spotCategory):
            return spotCategory.rawValue
        case .transport(let transportationCategory):
            return transportationCategory.rawValue
        }
    }

    func image() -> String {
        switch self {
        case .activity(let spotCategory):
            return spotCategory.image()
        case .transport(let transportationCategory):
            return transportationCategory.image()
        }
    }
}

// Spotのサブカテゴリー
enum Activity: String, CaseIterable {
    case dining = "食事"
    case shopping = "買い物"
    case activity = "体験"
    case sightseeing = "観光"
    // 追加・検討してほしい！

    func image() -> String {
        switch self {
        case .dining:
            "fork.knife"
        case .shopping:
            "takeoutbag.and.cup.and.straw"
        case .activity:
            "figure.mixed.cardio"
        case .sightseeing:
            "building.columns"
        }
    }
}

// Transportationのサブカテゴリー
enum Transport: String, CaseIterable {
    case car = "車"
    case bus = "バス"
    case walking = "徒歩"
    case train = "電車"
    // 追加・検討してほしい！

    func image() -> String {
        switch self {
        case .car:
            "car"
        case .bus:
            "bus"
        case .walking:
            "figure.walk"
        case .train:
            "tram"
        }
    }
}

// モックデータ作成
let mockActions: [Action] = [
    Action(
        name: "浅草寺",
        category: .activity(.sightseeing),
        startTime: Calendar.current.date(bySettingHour: 10, minute: 0, second: 0, of: Date())!, endTime: Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date()), memo: "東京で最も有名な寺院の一つで、観光客に人気があります。" // 終了時刻を正午に設定
    ),
    Action(
        name: "秋葉原",
        category: nil,
        startTime: Calendar.current.date(bySettingHour: 14, minute: 0, second: 0, of: Date())!, memo: "電気製品やアニメ関連商品が豊富に揃うエリアです。" // 終了時刻を午後4時に設定
    ),
    Action(
        name: "東京ディズニーランド",
        category: .activity(.activity),
        startTime: Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!,
        endTime: Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date()), // 終了時刻を午後6時に設定
        memo: "夢の国、東京ディズニーランドで楽しむアトラクションやショー。"
    ),
    Action(
        name: "JR山手線",
        category: .transport(.train),
        startTime: Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date())!, endTime: Calendar.current.date(bySettingHour: 18, minute: 30, second: 0, of: Date())!, memo: "東京を一周する主要な鉄道路線です。" // 終了時刻はなし
    ),
    Action(
        name: "晩ご飯",
        category: .activity(.dining),
        startTime: Calendar.current.date(bySettingHour: 19, minute: 0, second: 0, of: Date())!, endTime: nil, memo: "どこいくかは未定" // 終了時刻はなし
    )
]
