//
//  CreateTripView.swift
//  Tripper
//
//  Created by 森田匠 on 2024/10/26.
//

import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseStorage

struct InputTripView: View {
    @State private var title: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var prefecture: Prefecture = .tokyo
    @State private var photoItem: PhotosPickerItem?
    @State private var tripImageData: Data?
    @State private var selectedImage: Image? = nil
    @State private var isPublic: Bool = false

    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @State private var showImagePicker: Bool = false

    @Binding var trips: [Trip]
    @Environment(\.dismiss) var dismiss
    @FocusState private var showKeyboard: Bool

    @AppStorage("user_profile_url") private var profileURL: URL?
    @AppStorage("user_name") private var userNameStored: String = ""
    @AppStorage("user_UID") private var userUID: String = ""

    /// - Callbakcs
    var onTrip: (Trip)->()

    var body: some View {
        Form {
            Section {
                HStack {
                    Text("タイトル")
                    TextField("旅行タイトルを入力", text: $title)
                        .multilineTextAlignment(TextAlignment.trailing)
                        .focused($showKeyboard)
                }

                Picker("都道府県", selection: $prefecture) {
                    ForEach(Prefecture.allCases) { prefecture in
                        Text(prefecture.rawValue)
                            .tag(prefecture)
                    }
                }
            }

            Section {
                DatePicker("開始日", selection: $startDate, displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "ja_JP"))
                DatePicker("終了日", selection: $endDate, displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "ja_JP"))
            }

            Section {
                HStack {
                    Text("トリップ画像")
                    Spacer()
                    Button {
                        showImagePicker.toggle()
                    } label: {
                        Text("フォルダから選択")
                    }
                }

                if let tripImageData, let image = UIImage(data: tripImageData) {
                    GeometryReader {
                        let size = $0.size
                        let _ = print(size)
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(Rectangle())
                            .overlay(alignment: .topTrailing) {
                                Button {
                                    withAnimation(.easeInOut(duration: 0.25)) {
                                        self.tripImageData = nil
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                        .fontWeight(.bold)
                                        .tint(.red)
                                }
                                .padding(10)
                            }
                    }
                    .clipped()
                    .frame(width: 80, height: 80)
                    .hAlign(.center)
                }
            }

            Section {
                Toggle("トリップを公開する", isOn: $isPublic)
            }

            Button(action: createNewTrip) {
                Text("トリップを作成")
                    .foregroundColor(Color.white)
                    .bold()
            }
            .hAlign(.center)
            .vAlign(.center)
            .background(Color.blue)
            .listRowInsets(EdgeInsets())
            .disableWithOpacity(title == "" || isLoading)
            .navigationTitle("トリップ作成")
        }
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .onChange(of: photoItem) {
            if let photoItem {
                Task {
                    if let rawImageData = try? await photoItem.loadTransferable(type: Data.self), let image = UIImage(data: rawImageData), let compressedImageData = image.jpegData(compressionQuality: 0.5) {
                        /// UI Must be done on Main Thread
                        await MainActor.run {
                            tripImageData = compressedImageData
                            self.photoItem = nil
                        }
                    }
                }
            }
        }
        .alert(errorMessage, isPresented: $showError, actions: {})
        .overlay {
            LoadingView(show: $isLoading)
        }
    }

    func createNewTrip() {
        isLoading = true
        showKeyboard = false
        Task {
            do {
                guard let profileURL = profileURL else {return}
                // Step 1: Uploading Image If any
                // Used to delete the Post(Later shown in the video)
                let imageReferenceID = "\(userUID)\(Date())"
                let storageRef = Storage.storage().reference().child("Trip_Images").child(imageReferenceID)
                if let tripImageData {
                    let _ = try await storageRef.putDataAsync(tripImageData)
                    let downloadURL = try await storageRef.downloadURL()

                    // Step 3: Create Post Object With Image ID And URL
                    let trip = Trip(title: title,
                                    startDate: startDate,
                                    endDate: endDate,
                                    imageUrl: downloadURL,
                                    imageReferenceID: imageReferenceID,
                                    prefecture: [prefecture],
                                    isPublic: isPublic,
                                    creatorName: userNameStored,
                                    creatorUID: userUID,
                                    creatorProfileURL: profileURL)
                    try await createDocumentAtFirebase(trip)
                } else {
                    // Step 2: Directly Post Text Data to Firebase (Since there is no Images Present)
                    let trip = Trip(title: title,
                                    startDate: startDate,
                                    endDate: endDate,
                                    prefecture: [prefecture],
                                    isPublic: isPublic,
                                    creatorName: userNameStored,
                                    creatorUID: userUID,
                                    creatorProfileURL: profileURL)
                    try await createDocumentAtFirebase(trip)
                }
            } catch {
                await setError(error)
            }
        }
    }

    func createDocumentAtFirebase(_ trip: Trip) async throws {
        let doc = Firestore.firestore().collection("Trips").document()
        let _ = try doc.setData(from: trip) { error in
            if error == nil {
                isLoading = false
                var updatedTrip = trip
                updatedTrip.id = doc.documentID
                onTrip(updatedTrip)
                dismiss()
            }
        }
    }

    func setError(_ error: Error) async {
        await MainActor.run {
            errorMessage = error.localizedDescription
            showError.toggle()
        }
    }
}

extension InputTripView{
    private var AddNewTripButton: some View {
        NavigationLink {
            TripDetailView(trip: $trips.last!, trips: $trips)
        } label: {
            Text("トリップを作成")
                .foregroundColor(Color.blue)
        }
    }
}

//#Preview {
//    @Previewable @State var trip = [mockTrip]
//    NavigationStack {
//        InputTripView(trips: $trip) { _ in
//
//        }
//    }
//}
