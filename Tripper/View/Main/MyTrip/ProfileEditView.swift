//
//  ProfileEditView.swift
//  Tripper
//
//  Created by 森田匠 on 2024/10/27.
//

import SwiftUI
import SDWebImageSwiftUI
import PhotosUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
//import FirebaseDatabaseInternal

struct ProfileEditView: View {
    @Binding var user: User

//    var ref: DatabaseReference!
//    var ref = Database.database().reference()
 //   let ref = Database.database().reference()

    @State private var username: String = ""
    @State private var userEmail: String = ""
    @State private var userProfileURL: URL
    @State private var image: Image?
    @State private var userBio: String = ""
    @State private var errorMessage: String?
    @State var photoItem: PhotosPickerItem?

    @State var userProfilePicData: Data?
    @State var showImagePicker: Bool = false

    @Environment(\.dismiss) var dismiss

    init(user: Binding<User>) {
        self._user = user
        self._username = State(initialValue:user.username.wrappedValue)
        self._userEmail = State(initialValue:user.userEmail.wrappedValue)
        self._userProfileURL = State(initialValue:user.userProfileURL.wrappedValue)
        self._userBio = State(initialValue:user.userBio.wrappedValue)
    }

    var body: some View {
        Form {
            Section(header: Text("プロフィール編集")) {
                HStack {
                    Text("名前")
                    TextField("名前を入力", text: $username)
                        .multilineTextAlignment(TextAlignment.trailing)
                }

                HStack {
                    Text("Email")
                    TextField("メールアドレスを入力", text: $userEmail)
                        .multilineTextAlignment(TextAlignment.trailing)
                }
            }

            VStack(spacing: 20) {
                WebImage(url: userProfileURL) { image in
                    image
                } placeholder: {
                    Image("image")
                }
                .resizable()        // 画像をリサイズ可能にする
                .scaledToFit()      // アスペクト比を維持してフレーム内に収める
                .frame(width: 100, height: 100)  // 表示したいサイズを指定
                .clipped()          // フレームを超える部分をクリップ
                .onTapGesture {
                    showImagePicker.toggle()
                }
                .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
                .onChange(of: photoItem) {
                    // MARK: Extracting UIImage From PhotoItem
                    if let photoItem {
                        Task {
                            do {
                                guard let imageData = try await photoItem.loadTransferable(type: Data.self) else {return}
                                userProfilePicData = imageData
                            } catch {}
                        }

                    }
                }
                Button(action: registeUserProfileURL){
                    Text("適用する")
                }
            }
            .padding()

            Section(header: Text("ステータスメッセージ")) {
                HStack {
                    Text("メッセージ")
                    TextField("メッセージを入力", text: $userBio)
                        .multilineTextAlignment(TextAlignment.trailing)
                }
            }

            Button(action: replaceUser)
            {
                Text("イベントを追加")
                    .foregroundColor(Color.blue)
                    .bold()
            }
        }
    }

    func replaceUser() {
        let updateUser = User(username: username, userUID: user.userUID, userEmail: userEmail, userProfileURL: userProfileURL, userBio: userBio)
        user = updateUser
        //self.ref.child("Users/\(user.user)/username").setValue(username)
        //self.ref.child("Users").child(user.userUID).setValue(["username": username, "userProfileURL": userProfileURL, userEmail:  userEmail])
        Firestore.firestore().collection("Users").document(user.userUID)
        dismiss()
    }

    func registeUserProfileURL() {
        // isLoading = true
        closekeyboard()
        Task {
            do {
                guard let imageData = userProfilePicData else {return}
                let storageRef = Storage.storage().reference().child("Profile_Images").child(user.userUID)
                _ = try await storageRef.putDataAsync(imageData)
                let downloadURL = try await storageRef.downloadURL()
                // Step4: Creating a User Firestore Object
                userProfileURL = downloadURL
            } catch {

            }
        }
    }
}

#Preview {
    @Previewable @State var user = mockUser
    ProfileEditView(user: $user)
}
