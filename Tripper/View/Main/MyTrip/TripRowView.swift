//
//  TripRowView.swift
//  Tripper
//
//  Created by 森祐樹 on 2024/10/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct TripRowView: View {
    var trip: Trip
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                WebImage(url: trip.imageUrl) { image in
                    image
                } placeholder: {
                    Image("NullProfile")
                        .resizable()
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("\(trip.formattedDateRange())")
                    .foregroundColor(.black)
                    .font(.footnote)
                    .padding(.top, 10)
                HStack(alignment: .top) {
                    Text(trip.title)
                        .lineLimit(1)
                        .font(.title3)
                        .foregroundColor(.primary)

                    Spacer()

                    HStack(spacing: 0) {
                        Image(systemName: "heart")
                            .foregroundColor(.pink)
                        Text("\(trip.likedIDs.count)")
                    }
                    .font(.callout)
                    .lineLimit(1)
                    .foregroundColor(.secondary)
                    .padding(.trailing, 6)

                    HStack(spacing: 0) {
                        Image(systemName: "doc.on.doc")
                        Text("\(trip.copiedIDs.count)")
                    }
                    .font(.callout)
                    .lineLimit(1)
                    .foregroundColor(.secondary)
                }
            }
        }
        .hAlign(.leading)
        .padding(.horizontal, 20)
        .padding(.vertical, 3)
    }
}

#Preview {
    TripRowView(trip: mockTrip)
    TripRowView(trip: mockTrip)
    TripRowView(trip: mockTrip)
}
