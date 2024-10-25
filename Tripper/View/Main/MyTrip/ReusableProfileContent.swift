//
//  ReusableProfileContent.swift
//  Tripper
//
//  Created by 森祐樹 on 2024/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReusableProfileContent: View {
    @State private var fetchedTrips: [Trip] = [mockTrip]
    var user: User
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                HStack(spacing: 12) {
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

                    Text(user.username)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .hAlign(.leading)
                }

                Text("トリップ一覧")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .hAlign(.leading)
                    .padding(.vertical, 16)

                TripListView(trips: $fetchedTrips)
            }
            .padding(16)
        }
    }
}

#Preview {
    NavigationStack {
        ReusableProfileContent(user: User(username: "yuki", userUID: "aaa",
                                          userEmail: "test@123.com", userProfileURL: URL(fileURLWithPath: "")))
    }
}
