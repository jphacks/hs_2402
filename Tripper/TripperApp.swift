//
//  TripperApp.swift
//  Tripper
//
//  Created by 森祐樹 on 2024/10/23.
//

import SwiftUI
import Firebase

@main
struct TripperApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
