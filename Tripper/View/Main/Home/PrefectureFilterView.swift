////
////  PrefectureFilterView.swift
////  Tripper
////
////  Created by 森祐樹 on 2024/10/26.
////
//
//import SwiftUI
//
//struct PrefectureFilterView: View {
//    @State var selectedPrefecture: Prefecture? = nil
//    var body: some View {
//        List(JapaneseRegion.allCases) { region in
//            Section(header: Text(region.rawValue)) {
//                ForEach(region.prefectures) { prefecture in
//                    HStack {
//                        Image("\(prefecture)")
//                            .resizable()
//                            .frame(width: 30, height: 30)
//                        Text(prefecture.rawValue)
//                    }
//                }
//            }
//        }
//        .navigationDestination(item: $selectedPrefecture) { prefecture in
//            PrefectureTripListView(prefecture: prefecture)
//        }
//    }
//}
//
//#Preview {
//    NavigationStack {
//        PrefectureFilterView()
//    }
//}
