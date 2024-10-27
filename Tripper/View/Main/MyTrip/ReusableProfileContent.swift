//
//  ReusableProfileContent.swift
//  Tripper
//
//  Created by 森祐樹 on 2024/10/24.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage


enum PageType: CaseIterable {
    case myTrips
    case likeTrips

    func toString() -> String {
        switch self {
        case .myTrips:
            "マイトリップ"
        case .likeTrips:
            "いいねしたトリップ"
        }
    }
}

struct ReusableProfileContent: View {
    @State var fetchedMyTrips: [Trip] = []
    @State private var fetchedLikeTrips: [Trip] = [mockTrip]
    @State var pageType: PageType = .myTrips

    @State var selectedUser: User = mockUser
    @AppStorage("user_UID") var myUserUID: String = ""

    init(user: User) {
        self._selectedUser = State(initialValue: user)
    }


    var body: some View {
        LazyVStack {
            VStack(alignment: .leading) {
                HStack(spacing: 10) {
                    VStack(alignment: .leading) {
                        WebImage(url: selectedUser.userProfileURL) { image in
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
                        Text("\(fetchedMyTrips.count)")
                        Text("投稿数")
                    }
                    .padding(.horizontal, 10)

                    VStack(alignment: .center) {
                        Text("\(selectedUser.followers.count)")
                        Text("フォロワー")
                    }

                    VStack(alignment: .center) {
                        Text("\(selectedUser.follows.count)")
                        Text("フォロー中")
                    }
                }

                HStack {
                    Text(selectedUser.username)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.leading, 8)
                    Spacer()
                    if selectedUser.userUID != myUserUID  {
                        if selectedUser.followers.contains(myUserUID) {
                            Button {
                                cancelFollow()
                            } label: {
                                Text("フォロー中")
                                    .tint(.black)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 30)
                                    .background {
                                        RoundedRectangle(cornerRadius: 8).stroke(Color.mint, lineWidth: 2)
                                    }
                            }
                        } else {
                            Button {
                                follow()
                            } label: {
                                Text("フォロー")
                                    .tint(.black)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 30)
                                    .background(Color.mint.cornerRadius(8))
                            }
                        }
                    }
                }

                Text(selectedUser.userBio)
                    .padding(.leading, 8)
            }
        }
        .padding(5)
        .onAppear() {
            Task {
                await fetchUserTrips(user: selectedUser)
            }
        }

        VStack(spacing: 0) {
            TabBarView(currentTab: $pageType)
                .padding(.top, 10)
            Divider()
        }
        TabView(selection: $pageType) {
            TripListView(trips: $fetchedMyTrips)
                .tag(PageType.myTrips)

            TripListView(trips: $fetchedLikeTrips)
                .tag(PageType.likeTrips)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                NavigationLink {
                    InputTripView(trips: $fetchedMyTrips) { trip in
                        fetchedMyTrips.append(trip)
                        fetchedMyTrips.sort { $0.startDate > $1.startDate }
                    }
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    func fetchUserTrips(user: User) async {
        guard let uid = user.id else { return }
        do {
            // Firestore クエリでユーザーIDで絞り込んで取得
            let snapshot = try await Firestore.firestore()
                .collection("Trips")
                .whereField("creatorUID", isEqualTo: uid)
                .getDocuments()

            // 取得したドキュメントを `[Trip]` にデコード
            self.fetchedMyTrips = try snapshot.documents.compactMap { document in
                try document.data(as: Trip.self)
            }
        } catch {
            print("旅行取得失敗：\(error.localizedDescription)")
        }
    }

    func follow() {
        Task {
            // 自分のフォローに相手ユーザを追加
            try await Firestore.firestore().collection("Users").document(myUserUID).updateData([
                "follows": FieldValue.arrayUnion([selectedUser.userUID])
            ])

            // 相手のフォロワーに自分を追加
            try await Firestore.firestore().collection("Users").document(selectedUser.userUID).updateData([
                "followers": FieldValue.arrayUnion([myUserUID])
            ])

            selectedUser.followers.append(myUserUID)
        }
    }

    func cancelFollow() {
        Task {
            // 自分のフォローから相手ユーザを削除
            try await Firestore.firestore().collection("Users").document(myUserUID).updateData([
                "follows": FieldValue.arrayRemove([selectedUser.userUID])
            ])

            // 相手のフォロワーから自分を削除
            try await Firestore.firestore().collection("Users").document(selectedUser.userUID).updateData([
                "followers": FieldValue.arrayRemove([myUserUID])
            ])
            selectedUser.followers.removeAll(where: {$0 == "\(myUserUID)"})
        }
    }
}


#Preview {
    NavigationStack {
        ReusableProfileContent(user: mockUser)
    }
}
