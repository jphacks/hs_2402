//
//  TabBarView.swift
//  HitMaker
//
//  Created by 大野友暉 on 2024/10/26.
//

import SwiftUI

struct TabBarView: View {
    @Binding var currentTab: PageType
    @Namespace var namespace
    var body: some View {
        HStack(alignment: .bottom) {
            ForEach(PageType.allCases, id: \.self) { pagetype in
                TabBarItem(currentTab: $currentTab,
                           namespace: namespace,
                           tabBarItemName: pagetype.toString(),
                           tab: pagetype)
            }
        }
        .padding(.horizontal)
        .background(Color.white)
    }
}

struct TabBarItem: View {
    @Binding var currentTab: PageType
    let namespace: Namespace.ID
    var tabBarItemName: String
    var tab: PageType
    var body: some View {
        Button {
            currentTab = tab
        } label: {
            VStack(spacing: 8) {
                if currentTab == tab {
                    Text(tabBarItemName)
                        .foregroundColor(.mint)
                        .font(.callout)
                        .bold()
                    Color.mint
                        .frame(height: 2)
                        .matchedGeometryEffect(id: "underline",
                                               in: namespace,
                                               properties: .frame)
                } else {
                    Text(tabBarItemName)
                        .foregroundColor(.secondary)
                        .font(.callout)
                    Color.clear.frame(height: 2)
                }
            }
            .animation(.spring(), value: currentTab)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    @Previewable @State var pageType: PageType = .likeTrips
    TabBarView(currentTab: $pageType)
}
