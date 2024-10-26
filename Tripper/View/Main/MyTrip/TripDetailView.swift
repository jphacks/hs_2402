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
    var body: some View {
        LazyVStack {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading,spacing: 0) {
                            HStack(spacing: 0) {
                                Text(trip.formattedDateRange())
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 4)
                                Image(systemName: "heart")
                                    .font(.title3)
                                    .foregroundColor(.pink)
                                    .padding(.leading, 12)
                                Text("\(trip.likedIDs.count)")
                                    .foregroundColor(.gray)
                                    .font(.footnote)
                                    .padding(.trailing, 8)
                                Image(systemName: "doc.on.doc")
                                    .foregroundColor(.gray)
                                    .font(.callout)
                                Text("\(trip.copiedIDs.count)")
                                    .foregroundColor(.gray)
                                    .font(.footnote)
                            }

                            Text("\(trip.title)")
                                .font(.title)
                                .padding(.horizontal, 4)
                        }.padding(.bottom, 1)



                        HStack(spacing: 0) {
                            Text("作成者:\(trip.creatorName)")
                                .font(.callout)
                                .foregroundColor(.gray)
                                .padding(.horizontal, 4)

                            Text("行き先:\(trip.joinedPrefectureNames())")
                                .font(.callout)
                                .foregroundColor(.gray)
                                .padding(.horizontal, 4)
                        }
                        .font(.callout)
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                        .padding(.horizontal,4)

                    }
                    .padding(.horizontal, 12)

                    Spacer()

                    VStack(alignment: .leading) {
                        WebImage(url: trip.imageUrl) { image in
                            image
                        } placeholder: {
                            Image("NullProfile")
                                .resizable()
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipShape(Rectangle())
                    }
                    .padding(.trailing, 16)


                }
                .padding(.bottom, 12)
            }
        }
        .padding(5)

        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                // プラン内容
                ForEach(trip.actions){ action in
                    ActionRowView(action: action)
                    Divider()
                }
            }
            .padding(.horizontal, 24)
        }
        .hAlign(.center).vAlign(.top)
        .background(Color(UIColor.systemGray6))
        .overlay(alignment: .bottomTrailing) {
            AddActionButton
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
}

#Preview {
    @Previewable @State var trip = mockTrip
    NavigationStack {
        TripDetailView(trip: $trip)
    }
}
