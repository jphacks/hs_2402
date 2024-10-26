//
//  CreatePlanView.swift
//  CreatePlan
//
//  Created by 森田匠 on 2024/10/22.
//

import SwiftUI
import SDWebImageSwiftUI


struct TripDetailView: View {
    @Binding var trip: Trip
    @Binding var trips: [Trip]

    @State private var showingDialog: Bool = false
    @State private var isEditAction: Bool = false
    @State private var selectedAction: Action?  // 現在選択されたアクションを保存
    @Environment(\.dismiss) var dismiss


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
                                .padding(.trailing, 12)
                            Menu {
                                Button {
                                    print("a")
                                } label: {
                                    Text("プロフィール編集")
                                }
                                Button {
                                    deleteTrip(deletedTrip: trip)
                                } label: {
                                    Text("トリップ削除")
                                }

                            } label: {
                                Image(systemName: "gearshape.fill")
                                    .foregroundColor(.secondary)
                                    .font(.callout)
                            }
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
                        ForEach(trip.actions){ action in
                            ActionRowView(action: action)
                                .onTapGesture {
                                    selectedAction = action  // タップしたアクションを保存
                                    showingDialog.toggle()
                                }
                            Divider()
                        }
                    }
                    .padding(.horizontal, 24)
                    .navigationTitle("")
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
                            deleteAction(action: selectedAction!)
                        }
                    }
                }
                .overlay(alignment: .bottomTrailing) {
                    AddActionButton
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
    private var AddActionButton: some View {
        NavigationLink {
            InputActionView(trip: $trip)
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 30))    // プラスマークの大きさを指定
                .foregroundColor(.white)
                .padding()
                .background(Color.black)
                .clipShape(Circle())        // ボタンを丸くする
                .shadow(radius: 10)         // ボタンに影を付ける
        }
        .padding()  // 右下に余白を追加
    }

    func deleteAction(action: Action) {
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

    func deleteTrip(deletedTrip: Trip) {
        var index: Int?

        for i in 0..<trips.count {
            if trips[i].id == deletedTrip.id{
                index = i
            }
        }
        if index != nil {
            trips.remove(at: index!)
        }
        dismiss()
    }
}

//#Preview {
//    @Previewable @State var trip = mockTrip
//    NavigationStack {
//        TripDetailView(trip: $trip, trips: Binding<[mockTri]>)
//    }
//}
