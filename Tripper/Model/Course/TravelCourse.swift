//
//  TravelCourse.swift
//  TestTourApp
//
//  Created by 森祐樹 on 2024/10/17.
//

import Foundation

struct TravelCourse: Identifiable {
    var id: String = UUID().uuidString         // 各コースの一意のID
    var title: String             // コースのタイトル
//    var departureDate: Date       // 出発日
//    var returnDate: Date          // 帰宅日
    var travelDate: Date
    var imageUrl: String?         // 旅を表す写真のURL（オプション）
    var prefecture: String?     // JapanesePrefecture (主な目的地（都市や国など）)
    var spots: [Schedule]             // 立ち寄るスポットのリスト
    var likes: Int = 0  // いいね数
}

let mockTravelCourse = TravelCourse(
    title: "東京旅行",
    travelDate: Date(),
    prefecture: "東京",   // .tokyo,
    spots: mockSchedules)
