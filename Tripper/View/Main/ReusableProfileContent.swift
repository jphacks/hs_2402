//
//  ReusableProfileContent.swift
//  Tripper
//
//  Created by 森祐樹 on 2024/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReusableProfileContent: View {
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

                Text("Post's")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .hAlign(.leading)
                    .padding(.vertical, 16)
            }
            .padding(16)
        }
    }
}

#Preview {
    ReusableProfileContent(user: User(username: "yuki", userUID: "aaa",
                                      userEmail: "test@123.com", userProfileURL: URL(fileURLWithPath: "")))
}
