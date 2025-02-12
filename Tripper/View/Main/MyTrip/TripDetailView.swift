//
//  CreatePlanView.swift
//  CreatePlan
//
//  Created by 森田匠 on 2024/10/22.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth


struct TripDetailView: View {
    @Binding var trip: Trip

    @State private var showingDialog: Bool = false
    @State private var isEditAction: Bool = false
    @State private var selectedAction: Action?
    //現在選択されたアクションを保存
    @AppStorage("user_UID") private var userUID: String = ""
    @AppStorage("user_name") var userNameStored: String = ""
    @Environment(\.dismiss) var dismiss
    @State var isCopyAlert = false


    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading,spacing: 0) {
                        HStack(spacing: 0) {
                            Text(trip.formattedDateRange())
                                .font(.headline)
                                .fontWeight(.regular)
                                .padding(.horizontal, 4)
                            Image(systemName: "heart")
                                .font(.title3)
                                .foregroundColor(.pink)
                                .padding(.leading, 12)
                            Text("\(trip.likedIDs.count)")
                                .foregroundColor(.secondary)
                                .font(.footnote)
                                .padding(.trailing, 8)
                            Image(systemName: "doc.on.doc")
                                .foregroundColor(.secondary)
                                .font(.callout)
                            Text("\(trip.copiedIDs.count)")
                                .foregroundColor(.secondary)
                                .font(.footnote)
                        }

                        Text("\(trip.title)")
                            .font(.title)
                            .fontWeight(.medium)
                            .padding(.leading, 4)
                    }

                    HStack(spacing: 8) {
                        Text("作成者: \(trip.creatorName)")
                            .font(.callout)
                            .foregroundColor(.gray)

                        Text("行き先: \(trip.joinedPrefectureNames())")
                            .font(.callout)
                            .foregroundColor(.gray)
                    }
                    .font(.callout)
                    .lineLimit(1)
                    .foregroundColor(.secondary)
                    .padding(.horizontal,6)
                }

                Spacer()

                WebImage(url: trip.imageUrl) { image in
                    image
                } placeholder: {
                    Image("sampleTripImage")
                        .resizable()
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipShape(Rectangle())
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)

            Divider()
            //ここからアクションリスト表示
            NavigationStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        // プラン内容
                        ForEach(trip.actions, id: \.self){ action in
                            ActionRowView(action: action)
                                .onTapGesture {
                                    if userUID == trip.creatorUID {

                                        selectedAction = action  // タップしたアクションを保存
                                        showingDialog.toggle()
                                    }
                                }
                            Divider()
                        }
                    }
                    .padding(.horizontal, 24)
                    .navigationTitle("\(trip.title)")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .hAlign(.center).vAlign(.top)
                .background(Color(UIColor.systemGray6))
                .confirmationDialog("", isPresented: $showingDialog) {
                    Button("編集") {
                        isEditAction = true // シートを表示
                    }
                    Button("削除", role: .destructive) {
                        if selectedAction != nil {
                            deleteTrip(action: selectedAction!)
                        }
                    }
                }
                .overlay(alignment: .bottomTrailing) {
                    if userUID == trip.creatorUID {
                        addActionButton
                    } else {
                        copyTripButton
                    }
                }
                .navigationDestination(isPresented: $isEditAction, destination: {
                    if let selectedAction = selectedAction {
                        ActionEditView(trip: $trip, action: selectedAction)
                    }
                })
            }
        }
    }
}

extension TripDetailView{
    private var addActionButton: some View {
        NavigationLink {
            InputActionView(trip: $trip)
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 30))    // プラスマークの大きさを指定
                .foregroundColor(.white)
                .padding()
                .background(Color.mint)
                .clipShape(Circle())        // ボタンを丸くする
                .shadow(radius: 10)         // ボタンに影を付ける
        }
        .padding()  // 右下に余白を追加
    }

    private var copyTripButton: some View {
        Button {
            isCopyAlert = true
        } label: {
            Image(systemName: "doc.on.doc")
                .font(.system(size: 30))    // プラスマークの大きさを指定
                .foregroundColor(.white)
                .padding()
                .background(Color.mint)
                .clipShape(Circle())        // ボタンを丸くする
                .shadow(radius: 10)         // ボタンに影を付ける
        }
        .padding()  // 右下に余白を追加
        .alert("コピーしてもいいですか?", isPresented: $isCopyAlert) {
            Button("キャンセル") {
            }
            Button("OK") {
                Task {
                    await copyTrip()
                }
                dismiss()
            }
        } 
    }

    func deleteTrip(action: Action) {
        var index: Int?

        for i in 0..<trip.actions.count {
            if trip.actions[i].id == action.id{
                index = i
            }
        }
        if index != nil {
            trip.actions.remove(at: index!)
        }
        dismiss()
    }

    func copyTrip() async {
        do {
            trip.creatorUID = userUID
            trip.creatorName = userNameStored
            trip.id = nil
            let encodedTrip = try Firestore.Encoder().encode(trip)
            try await Firestore.firestore().collection("Trips").document().setData(encodedTrip)
        } catch {
            print("データ保存失敗：\(error.localizedDescription)")
        }
    }
}

#Preview {
    @Previewable @State var trip = mockTrip
    NavigationStack {
        TripDetailView(trip: $trip)
    }
}
