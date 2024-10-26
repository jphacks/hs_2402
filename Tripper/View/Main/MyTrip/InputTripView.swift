//
//  CreateTripView.swift
//  Tripper
//
//  Created by 森田匠 on 2024/10/26.
//

import SwiftUI
import PhotosUI

struct InputTripView: View {
    @State private var title: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var prefecture: Prefecture = .tokyo
    @State private var image: PhotosPickerItem?
    @State private var selectedImage: Image? = nil
    @State private var isPublic: Bool = false
    @State private var isValidImage: Bool = false
    @State private var isNavigationActive: Bool = false
    @Binding var trips: [Trip]
    @Environment(\.dismiss) var dismiss
    var user: User

    var body: some View {
        Form {
            Section {
                HStack {
                    Text("タイトル")
                    TextField("旅行タイトルを入力", text: $title)
                        .multilineTextAlignment(TextAlignment.trailing)
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
                Toggle("トリップ画像", isOn: $isValidImage)
                if isValidImage{
                    PhotosPicker(selection: $image) {
                        Text("フォルダから選択する")
                    }
                    .onChange(of: image) {
                        Task {
                            if let image = image {
                                if let imageData = try? await image.loadTransferable(type: Data.self),
                                   let uiImage = UIImage(data: imageData) {
                                    //DataをUIImageに変換し、Imageビューに表示
                                    selectedImage = Image(uiImage: uiImage)
                                }
                            }
                        }
                    }
                    if let selectedImage = selectedImage {
                        selectedImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                    }
                }
            }

            Section {
                Toggle("トリップを公開する", isOn: $isPublic)
            }


            Button {
                addNewTrip()
                dismiss()
            } label: {
                Text("トリップを作成")
                    .foregroundColor(Color.white)
                    .bold()
            }
            .hAlign(.center)
            .vAlign(.center)
            .background(Color.blue)
            .listRowInsets(EdgeInsets())
            .navigationTitle("トリップ作成")
        }
    }

    func addNewTrip(){
        //構造体を定義
        let newtrip = Trip(
            title: title,
            startDate: startDate,
            endDate: endDate,
            imageUrl: nil,
            prefecture: [prefecture],
            ispublic: isPublic,
            creatorName: user.username,
            creatorUID: user.userUID,
            creatorProfileURL: user.userProfileURL)
        // 配列に格納
        trips.append(newtrip)
        trips.sort { $0.startDate > $1.startDate }
    }
}

extension InputTripView{
    private var AddNewTripButton: some View {
        NavigationLink {
            TripDetailView(trip: $trips.last!)
        } label: {
            Text("トリップを作成")
                .foregroundColor(Color.blue)
        }
    }
}

#Preview {
    @Previewable @State var trip = [mockTrip]
    NavigationStack {
        InputTripView(trips: $trip, user: mockUser)//引数は[trip]
    }
}
