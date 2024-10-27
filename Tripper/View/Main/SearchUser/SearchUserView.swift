//
//  SearchUserView.swift
//  Tripper
//
//  Created by 森祐樹 on 2024/10/27.
//

import SwiftUI
import FirebaseFirestore

struct SearchUserView: View {
    @State private var fetchedUsers: [User] = []
    @State private var searchText: String = ""
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            List {
                ForEach(fetchedUsers) { user in
                    NavigationLink {
                        ReusableProfileContent(user: user)
                    } label: {
                        Text(user.username)
                            .font(.callout)
                            .hAlign(.leading)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("ユーザを探す")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "検索")
            .onSubmit(of: .search, {
                Task { await searchUsers() }
            })
            .onChange(of: searchText, { oldValue, newValue in
                if newValue.isEmpty {
                    fetchedUsers = []
                }
            })
        }
    }

    func searchUsers() async {
        do {
            let documents = try await Firestore.firestore().collection("Users")
                .whereField("username", isGreaterThanOrEqualTo: searchText)
                .whereField("username", isLessThanOrEqualTo: "\(searchText)\u{f8ff}")
                .getDocuments()

            let users = try documents.documents.compactMap { doc -> User? in
                try doc.data(as: User.self)
            }

            await MainActor.run {
                fetchedUsers = users
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    SearchUserView()
}
