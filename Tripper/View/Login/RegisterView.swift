//
//  RegisterView.swift
//  Tripper
//
//  Created by 森祐樹 on 2024/10/24.
//

import SwiftUI
import PhotosUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

// MARK: Register View
struct RegisterView: View {
    @State var emailID: String = ""
    @State var password: String = ""
    @State var userName: String = ""
    @State var userProfilePicData: Data?

    @Environment(\.dismiss) var dismiss
    @State var showImagePicker: Bool = false
    @State var photoItem: PhotosPickerItem?
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
    // MARK: UserDefaults
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    var body: some View {
        VStack(spacing: 10) {
            Text("新規登録")
                .font(.largeTitle.bold())
                .hAlign(.leading)

            // MARK: For Smaller size Optimization
            ViewThatFits {
                ScrollView(.vertical, showsIndicators: false) {
                    helperView()
                }
                helperView()
            }

            // MARK: Register Button
            HStack {
                Text("Already have an account?")
                    .foregroundStyle(.gray)

                Button("Login Now") {
                    dismiss()
                }
                .fontWeight(.bold)
                .foregroundStyle(.black)
            }
            .font(.callout)
            .vAlign(.bottom)
        }
        .vAlign(.top)
        .padding(24)
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .onChange(of: photoItem) {
            // MARK: Extracting UIImage From PhotoItem
            if let photoItem {
                Task {
                    do {
                        guard let imageData = try await photoItem.loadTransferable(type: Data.self) else {return}
                        await MainActor.run(body: {
                            userProfilePicData = imageData
                        })
                    } catch {}
                }
            }
        }
        .alert(errorMessage, isPresented: $showError, actions: {})
    }

    @ViewBuilder
    func helperView() -> some View {
        VStack(spacing: 12) {
            ZStack {
                if let userProfilePicData, let image = UIImage(data: userProfilePicData) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    Image("NullProfile")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .frame(width: 85, height: 85)
            .clipShape(Circle())
            .contentShape(Circle())
            .onTapGesture {
                showImagePicker.toggle()
            }
            .padding(.top, 24)
            .padding(.bottom, 16)

            TextField("Username", text: $userName)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))

            TextField("Email", text: $emailID)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))

            SecureField("Password", text: $password)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))

            Button(action: registerUser) {
                Text("登録する")
                    .foregroundStyle(.white)
                    .hAlign(.center)
                    .fillView(.black)
            }
            .disableWithOpacity(shouldDisableButton() || isLoading)
            .padding(.top, 24)
        }
    }

    func registerUser() {
        isLoading = true
        closekeyboard()
        Task {
            do {
                // Step1: Creating Firebase Account
                try await Auth.auth().createUser(withEmail: emailID, password: password)
                // Step2: Uploading Profile Photo Into Firebase Storage
                guard let userUID = Auth.auth().currentUser?.uid else {return}
                guard let imageData = userProfilePicData else {return}
                let storageRef = Storage.storage().reference().child("Profile_Images").child(userUID)
                _ = try await storageRef.putDataAsync(imageData)
                // Step3: Downloading Photo URL
                let downloadURL = try await storageRef.downloadURL()
                // Step4: Creating a User Firestore Object
                let user = User(username: userName, userUID: userUID, userEmail: emailID, userProfileURL: downloadURL)
                // Step5: Saving User Doc into Firestore Database
                _ = try Firestore.firestore().collection("Users").document(userUID).setData(from: user) { error in
                    if error == nil {
                        // MARK: Print Saved Successfully
                        print("Saved Successfully")
                        userNameStored = userName
                        self.userUID = userUID
                        profileURL = downloadURL
                        logStatus = true
                    }
                }
            } catch {
                // MARK: Deleting Created Account In Case of Failure
                try await Auth.auth().currentUser?.delete()
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

    func shouldDisableButton() -> Bool {
        return userName == "" || emailID == "" || password == "" || userProfilePicData == nil
    }
}

#Preview {
    RegisterView()
}
