//
//  ProfileView.swift
//  Tripper
//
//  Created by 森祐樹 on 2024/10/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

struct MyTripView: View {
    @State private var myProfile: User?
    @AppStorage("log_status") var logStatus: Bool = false

    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                if let myProfile {
                    ReusableProfileContent(user: myProfile)
                        .refreshable {
                            self.myProfile = nil
                            await fetchUserData()
                        }
                } else {
                    ProgressView()
                        .vAlign(.center)
                        .hAlign(.center)
                }
            }
            .background(Color.white)
            .navigationTitle("マイトリップ")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        // MARK: Two Action's
                        // 1. Logout
                        Button("ログアウト", action: logOutUser)
                        // 2. Delete Account
                        Button("アカウント削除", role: .destructive, action: deleteAccount)
                    } label: {
                        Image(systemName: "ellipsis")
                            .tint(.black)
                    }
                }
            }
        }
        .overlay {
            LoadingView(show: $isLoading)
        }
        .alert(errorMessage, isPresented: $showError, actions: {})
        .task {
            // This Modifer is like onAppear
            // So Fetching for the First Time Only
            if myProfile != nil {return}
            await fetchUserData()
        }
    }

    func fetchUserData() async {
        guard let userUID = Auth.auth().currentUser?.uid else {return}
        let documentUsers = Firestore.firestore().collection("Users").document(userUID)
        guard let user = try? await documentUsers.getDocument(as: User.self) else {return}
        await MainActor.run {
            myProfile = user
        }
    }

    func logOutUser() {
        try? Auth.auth().signOut()
        logStatus = false
    }

    func deleteAccount() {
        isLoading = true
        Task {
            do {
                guard let userUID = Auth.auth().currentUser?.uid else {return}

                let reference = Storage.storage().reference().child("Profile_Images").child(userUID)
                try await reference.delete()

                try await Firestore.firestore().collection("Users").document(userUID).delete()

                try await Auth.auth().currentUser?.delete()
                logStatus = false
            } catch {
                await setError(error)
            }
        }
    }

    func setError(_ error: Error) async {
        await MainActor.run {
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading = false
        }
    }
}

#Preview {
    MyTripView()
}
