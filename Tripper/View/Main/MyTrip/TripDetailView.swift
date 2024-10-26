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
