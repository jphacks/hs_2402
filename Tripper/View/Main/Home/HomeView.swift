//
//  HomeView.swift
//  Tripper
//
//  Created by 森祐樹 on 2024/10/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 30) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("都道府県から選ぶ")
                            .font(.system(size: 22))
                            .fontWeight(.semibold)
                            .padding(.top, 24)
                            .padding(.bottom, -24)

                        ForEach(JapaneseRegion.allCases) { region in
                            Section {
                                ForEach(region.prefectures) { prefecture in
                                    NavigationLink {
                                        PrefectureTripListView(prefecture: prefecture)
                                    } label: {
                                        PrefectureCardView(prefecture: prefecture, cornerRadius: 8, height: 100)
                                    }
                                }
                            } header: {
                                HStack {
                                    Text(region.rawValue)
                                        .font(.system(size: 22))
                                        .fontWeight(.medium)
                                    Rectangle()
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 2)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.vertical, 12)
                                .padding(.top, 24)
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)
            }
            .navigationTitle("ホーム")
        }
    }
}

#Preview {
    HomeView()
}
