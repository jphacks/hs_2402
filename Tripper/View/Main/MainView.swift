//
//  MainView.swift
//  Tripper
//
//  Created by 森祐樹 on 2024/10/24.
//

import SwiftUI

struct MainView: View {
    // 初期化時に下部Tabの色を変更
    init() {
        let appearance: UITabBarAppearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().standardAppearance = appearance
    }
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("ホーム")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "rectangle.on.rectangle.angled")
                    Text("マイトリップ")
                }
        }
        .tint(.black)
    }
}

#Preview {
    MainView()
}
