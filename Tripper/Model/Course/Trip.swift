//
//  TravelCourse.swift
//  TestTourApp
//
//  Created by 森祐樹 on 2024/10/17.
//

import Foundation

// 旅行全体を表す構造体
struct Trip: Identifiable {
    var id: String = UUID().uuidString         // 各コースの一意のID
    var title: String             // コースのタイトル
//    var departureDate: Date       // 出発日
//    var returnDate: Date          // 帰宅日
    var travelDate: Date
    var imageUrl: String?         // 旅を表す写真のURL（オプション）
    var prefecture: String?     // JapanesePrefecture (主な目的地（都市や国など）)
    var actions: [Action]             // 立ち寄るスポットのリスト
    var likes: Int = 0  // いいね数
}

var mockTrip = Trip(
    title: "東京旅行",
    travelDate: Date(),
    prefecture: "東京",   // .tokyo,
    actions: mockActions)
