//
//  User.swift
//  Tripper
//
//  Created by 森祐樹 on 2024/10/24.
//

import FirebaseFirestore

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var username: String
    var userUID: String
    var userEmail: String
    var userProfileURL: URL
    var userBio: String = ""

    var myTrips: [Trip] = []
    var likeTrips: [Trip] = []
    var invitedTrips:[Trip] = []

    var follows: [String] = []
    var followers: [String] = []

    enum CodingKeys: CodingKey {
        case id
        case username
        case userUID
        case userEmail
        case userProfileURL
    }
}
