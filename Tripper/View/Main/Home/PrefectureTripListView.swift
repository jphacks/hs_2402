//
//  PrefectureTripListView.swift
//  Tripper
//
//  Created by 森祐樹 on 2024/10/26.
//

import SwiftUI
import Firebase

struct PrefectureTripListView: View {
    @State private var prefectureTrips: [Trip] = []
    @State private var isFetching: Bool = true
    @State private var paginationDoc: QueryDocumentSnapshot?
    let prefecture: Prefecture
    var body: some View {
        VStack {
            PrefectureCardView(prefecture: prefecture, cornerRadius: 0, height: 180)
                .shadow(radius: 2, y: 2)
            Group {
                if isFetching {
                    ProgressView()
                        .padding(.top, 28)
                } else {
                    if prefectureTrips.isEmpty {
                        // No Post's Found on Firestore
                        Text("登録されていません")
                            .foregroundStyle(.gray)
                            .padding(.top, 28)
                    } else {
                        // - Displaying Post's
                        TripListView(trips: $prefectureTrips)
                    }
                }
            }
            .navigationTitle("\(prefecture.nameWithSuffix)のトリップ")
            .navigationBarTitleDisplayMode(.inline)
        }
        .vAlign(.top)
        .refreshable {
            Task {
                // Disbalign Refresh for UID baased Post's
                isFetching = true
                prefectureTrips = []
                // Resetting Pagination Doc
                paginationDoc = nil
                await fetchPrefectureTrips()
            }
        }
        .task {
            guard prefectureTrips.isEmpty else {return}
            await fetchPrefectureTrips()
        }
    }

    func fetchPrefectureTrips() async {
        do {
            var query: Query!

            if let paginationDoc {
                query = Firestore.firestore().collection("Trips")
                    .order(by: "startDate", descending: true)
                    .start(afterDocument: paginationDoc)
                    .limit(to: 20)
            } else {
                query = Firestore.firestore().collection("Trips")
                    .order(by: "startDate", descending: true)
                    .limit(to: 20)
            }

            query = query.whereField("prefecture", arrayContains: prefecture.rawValue)

            let docs = try await query.getDocuments()
            let fetchedPosts = docs.documents.compactMap { doc -> Trip? in
                try? doc.data(as: Trip.self)
            }
            await MainActor.run {
                prefectureTrips.append(contentsOf: fetchedPosts)
                paginationDoc = docs.documents.last
                isFetching = false
            }
        } catch {
            print(error.localizedDescription)
            isFetching = false
        }
    }
}

#Preview {
    NavigationStack {
        PrefectureTripListView(prefecture: .tokushima)
    }
}
