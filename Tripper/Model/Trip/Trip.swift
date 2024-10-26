//
//  TravelCourse.swift
//  TestTourApp
//
//  Created by 森祐樹 on 2024/10/17.
//

import FirebaseFirestore


// 旅行全体を表す構造体
struct Trip: Identifiable, Codable, Equatable, Hashable {
    @DocumentID var id: String?
    var title: String
    var startDate: Date
    var endDate: Date
    var imageUrl: URL?
    var imageReferenceID: String = ""
    var prefecture: [Prefecture] = []
    var actions: [Action] = []
    var subtitles: [String] = []

    var isPublic: Bool = true
    var likedIDs: [String] = []
    var copiedIDs: [String] = []
    // MARK: Basic User Info
    var creatorName: String
    var creatorUID: String
    var creatorProfileURL: URL
    var tripMembers: [String] = []
}

extension Trip {
    func formattedDateRange() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"

        let start = dateFormatter.string(from: startDate)
        let end = dateFormatter.string(from: endDate)

        return "\(start) - \(end)"
    }

    func joinedPrefectureNames() -> String {
        var result = ""

        // forループで要素を取り出し、文字列を連結
        for (index, pref) in prefecture.enumerated() {
            result += "\(pref.rawValue)"
            if index < prefecture.count - 1 {
                result += "-"
            }
        }

        return result
    }

}

var mockTrip = Trip(id:"222", title: "東京旅行",
                    startDate: Date(),
                    endDate: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date(),
                    prefecture: [.tokyo],
                    actions: mockActions,
                    creatorName: "おーの",
                    creatorUID: "aaa",
                    creatorProfileURL: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/tripper-419d4.appspot.com/o/Profile_Images%2FOGDTXbgP2uUePKV0hl7CnETAAhX2?alt=media&token=e42e480d-6581-4d87-934c-7ec587c848c7") ?? URL(fileURLWithPath: "") )

var mockTrip2 = Trip(id:"111", title: "京都旅行",
                    startDate: Date(),
                    endDate: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date(),
                    prefecture: [.tokyo],
                    actions: mockActions,
                    creatorName: "おーの",
                    creatorUID: "aaa",
                    creatorProfileURL: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/tripper-419d4.appspot.com/o/Profile_Images%2FOGDTXbgP2uUePKV0hl7CnETAAhX2?alt=media&token=e42e480d-6581-4d87-934c-7ec587c848c7") ?? URL(fileURLWithPath: "") )
