//
//  ContentView.swift
//  Tripper
//
//  Created by 森祐樹 on 2024/10/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_status") var logStatus: Bool = false
    var body: some View {
        // MARK: Rerdirecting User Based on Log Status
        if logStatus {
            MainView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
