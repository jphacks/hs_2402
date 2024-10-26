//
//  CreateTripView.swift
//  Tripper
//
//  Created by 森田匠 on 2024/10/26.
//

import SwiftUI
import PhotosUI

struct CreateTripView: View {
    var user: User

    @State private var title: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var prefecture: Prefecture = .tokyo
    @State var image: PhotosPickerItem?
    @State private var selectedImage: Image? = nil
    @State private var isValidEndTime: Bool = true
    @State private var isPublic: Bool = false
    @State private var isValidImage: Bool = false
    @Binding var trip: [Trip]
    @State private var isNavigationActive: Bool = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("トリップ作成")) {
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

                DatePicker("開始日", selection: $startDate, displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "ja_JP"))
                HStack(alignment: .top, spacing: 0) {
                    Text("終了日")
                        .padding(.top, 4)
                    Spacer()
                    VStack {
                        DatePicker("", selection: $endDate, displayedComponents: .date)
                            .environment(\.locale, Locale(identifier: "ja_JP"))
                    }
                }

                Section {
                    HStack {
                        Text("イメージ")
                        Spacer()
                        Toggle(isOn: $isValidImage){}
                    }
                    if isValidImage{
                        PhotosPicker(selection: $image) {
                            Text("フォルダを表示")
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
                    HStack {
                        Text("公開する")
                        Spacer()
                        Toggle(isOn: $isPublic){}
                    }
                }

                Section{
                    //AddNewTripButton
                    Button(action: {
                        // ここに事前処理を記述
                        addNewTrip()
                        // 処理が完了したら、フラグを更新して遷移
                        isNavigationActive = true
                    }) {
                        Text("トリップを作成")
                        .foregroundColor(Color.blue)
                    }

                    NavigationLink(destination: TripDetailView(trip: $trip.last!), isActive: $isNavigationActive) {
                        EmptyView()
                    }
                }
            }
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
        trip.append(newtrip)
    }
}

extension CreateTripView{
    private var AddNewTripButton: some View {
        NavigationLink {
            TripDetailView(trip: $trip.last!)
        } label: {
            Text("トリップを作成")
                .foregroundColor(Color.blue)
        }
    }
}

#Preview {
    @Previewable @State var trip = [mockTrip]
    CreateTripView(user: mockUser, trip: $trip)//引数は[trip]
}
