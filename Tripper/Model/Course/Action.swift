//
//  Schedule.swift
//  TestTourApp
//
//  Created by 森祐樹 on 2024/10/17.
//

import Foundation

struct Action: Identifiable {
    var id: String = UUID().uuidString         // 各スポットの一意のID
    var name: String              // スポットの名称
    var category: Category?
    var memo: String?       // スポットの説明orメモ
    var address: String?           // スポットの住所
    var imageUrl: String?         // スポットの写真URL（オプション）
    var startTime: Date
    var endTime: Date?
}

enum Category {
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
let mockSchedules: [Action] = [
    Action(
        name: "浅草寺",
        category: .activity(.sightseeing),
        memo: "東京で最も有名な寺院の一つで、観光客に人気があります。",
        address: "東京都台東区浅草2-3-1",
        imageUrl: "https://example.com/asakusa_temple.jpg",
        startTime: Calendar.current.date(bySettingHour: 10, minute: 0, second: 0, of: Date())!, // 開始時刻を午前10時に設定
        endTime: Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date()) // 終了時刻を正午に設定
    ),
    Action(
        name: "秋葉原",
        category: .activity(.shopping),
        memo: "電気製品やアニメ関連商品が豊富に揃うエリアです。",
        address: "東京都千代田区外神田1丁目",
        imageUrl: "https://example.com/akihabara.jpg",
        startTime: Calendar.current.date(bySettingHour: 14, minute: 0, second: 0, of: Date())!, // 開始時刻を午後2時に設定
        endTime: Calendar.current.date(bySettingHour: 16, minute: 0, second: 0, of: Date()) // 終了時刻を午後4時に設定
    ),
    Action(
        name: "東京ディズニーランド",
        category: .activity(.activity),
        memo: "夢の国、東京ディズニーランドで楽しむアトラクションやショー。",
        address: "千葉県浦安市舞浜1-1",
        imageUrl: "https://example.com/tokyo_disneyland.jpg",
        startTime: Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!, // 開始時刻を午前9時に設定
        endTime: Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date()) // 終了時刻を午後6時に設定
    ),
    Action(
        name: "JR山手線",
        category: .transport(.train),
        memo: "東京を一周する主要な鉄道路線です。",
        address: nil,
        imageUrl: "https://example.com/yamanote_line.jpg",
        startTime: Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date())!, // 開始時刻はなし
        endTime: Calendar.current.date(bySettingHour: 18, minute: 30, second: 0, of: Date())! // 終了時刻はなし
    ),
    Action(
        name: "晩ご飯",
        category: .activity(.dining),
        memo: "どこいくかは未定",
        address: nil,
        imageUrl: "https://example.com/tokyo_bus.jpg",
        startTime: Calendar.current.date(bySettingHour: 19, minute: 0, second: 0, of: Date())!, // 開始時刻はなし
        endTime: nil // 終了時刻はなし
    )
]
