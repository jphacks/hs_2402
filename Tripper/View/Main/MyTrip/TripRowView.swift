//
//  TripRowView.swift
//  Tripper
//
//  Created by 森祐樹 on 2024/10/25.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseFirestore
import FirebaseAuth



struct TripRowView: View {
    @Binding var trip: Trip
    @AppStorage("user_UID") private var userUID: String = ""

    var body: some View {
        HStack(alignment: .top) {
            VStack {
                WebImage(url: trip.imageUrl) { image in
                    image
                } placeholder: {
                    Image("sampleTripImage")
                        .resizable()
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(Rectangle())
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
                        Button {
                            Task {
                                await pushLike()
                            }
                        } label: {
                            if trip.likedIDs.contains(userUID){
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.pink)
                            } else {
                                Image(systemName: "heart")
                                    .foregroundColor(.pink)
                            }
                        }

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

    func pushLike() async {
        if trip.likedIDs.contains(userUID) {
            // Unlike functionality
            if let index = trip.likedIDs.firstIndex(of: userUID) {
                trip.likedIDs.remove(at: index)
            }

            do {
                guard let tripId = trip.id else { return }
                let encodedTrip = try Firestore.Encoder().encode(trip)
                try await Firestore.firestore().collection("Trips").document(tripId).setData(encodedTrip, merge: true)
            } catch {
                print("データ保存失敗：\(error.localizedDescription)")
            }

            let documentUsers = Firestore.firestore().collection("Users").document(userUID)
            guard var user = try? await documentUsers.getDocument(as: User.self) else { return }

            if let tripIndex = user.likeTrips.firstIndex(where: { $0.id == trip.id }) {
                user.likeTrips.remove(at: tripIndex)
            }

            do {
                let encodedUser = try Firestore.Encoder().encode(user)
                try await Firestore.firestore().collection("Users").document(userUID).setData(encodedUser, merge: true)
            } catch {
                print("データ保存失敗：\(error.localizedDescription)")
            }

        } else {
            // Like functionality
            trip.likedIDs.append(userUID)
            do {
                guard let tripId = trip.id else { return }
                let encodedTrip = try Firestore.Encoder().encode(trip)
                try await Firestore.firestore().collection("Trips").document(tripId).setData(encodedTrip, merge: true)
            } catch {
                print("データ保存失敗：\(error.localizedDescription)")
            }

            let documentUsers = Firestore.firestore().collection("Users").document(userUID)
            guard var user = try? await documentUsers.getDocument(as: User.self) else { return }

            do {
                let encodedUser = try Firestore.Encoder().encode(user)
                try await Firestore.firestore().collection("Users").document(userUID).setData(encodedUser, merge: true)
            } catch {
                print("データ保存失敗：\(error.localizedDescription)")
            }
        }
    }
}

//#Preview {
//    TripRowView(trip: mockTrip)
//    TripRowView(trip: mockTrip)
//    TripRowView(trip: mockTrip)
//}
