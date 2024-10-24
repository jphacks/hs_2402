//
//  HomeView.swift
//  Tripper
//
//  Created by 森祐樹 on 2024/10/24.
//

import SwiftUI

struct HomeView: View {
    @State var currentTab: Int = 1

    // 初期化時にUIPageControlの色を変更
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
    }

    var body: some View {
        TabView(selection: $currentTab) {
            Text("イベント選択")
                .tag(0)
                .tabItem {
                    Image(systemName: "figure.2")
                }
            Text("地域選択")
                .tag(1)
                .tabItem {
                    Image(systemName: "mappin")
                }
            Text("移動手段選択")
                .tag(2)
                .tabItem {
                    Image(systemName: "airplane")
                }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .background(Color(UIColor.systemGray6))
    }
}

#Preview {
    HomeView()
}
