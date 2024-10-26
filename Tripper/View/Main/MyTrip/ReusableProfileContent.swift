//
//  ReusableProfileContent.swift
//  Tripper
//
//  Created by 森祐樹 on 2024/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

enum PageType: CaseIterable {
    case myTrips
    case likeTrips

    func toString() -> String {
        switch self {
        case .myTrips:
            "私のトリップ"
        case .likeTrips:
            "いいねしたトリップ"
        }
    }
}

struct ReusableProfileContent: View {
    @State private var fetchedMyTrips: [Trip] = [mockTrip, mockTrip]
    @State private var fetchedLikeTrips: [Trip] = [mockTrip]
    @State var pageType: PageType = .myTrips

    var user: User

    var body: some View {
        LazyVStack {
            VStack(alignment: .leading) {
                HStack(spacing: 10) {
                    VStack(alignment: .leading) {
                        WebImage(url: user.userProfileURL) { image in
                            image
                        } placeholder: {
                            Image("NullProfile")
                                .resizable()
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())

                    }

                    VStack(alignment: .center) {
                        Text("\(user.myTrips.count)")
                        Text("投稿数")
                    }
                    .padding(.horizontal, 10)

                    VStack(alignment: .center) {
                        Text("\(user.followers.count)")
                        Text("フォロワー")
                    }

                    VStack(alignment: .center) {
                        Text("\(user.follows.count)")
                        Text("フォロー中")
                    }
                }

                Text(user.username)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.leading, 8)

                Text(user.userBio)
                    .padding(.leading, 8)
            }
        }
        .padding(5)

        VStack(spacing: 0) {
            TabBarView(currentTab: $pageType)
                .padding(.top, 10)
            Divider()
        }
        TabView(selection: $pageType) {
            TripListView(trips: $fetchedMyTrips)
                .tag(PageType.myTrips)

            Text("aaa")
                .tag(PageType.likeTrips)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

#Preview {
    NavigationStack {
        ReusableProfileContent(user: mockUser)
    }
}
