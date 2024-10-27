//
//  PrefectureTripListView.swift
//  Tripper
//
//  Created by 森祐樹 on 2024/10/26.
//

import SwiftUI

struct PrefectureTripListView: View {
    let prefecture: Prefecture
    var body: some View {
        VStack {
            Text(prefecture.nameWithSuffix)
            Image("\(prefecture)")
                .resizable()
                .frame(width: 30, height: 30)
        }
    }
}

#Preview {
    PrefectureTripListView(prefecture: .tokushima)
}
