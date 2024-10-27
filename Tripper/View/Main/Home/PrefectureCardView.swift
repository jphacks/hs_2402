//
//  PrefectureCardView.swift
//  Tripper
//
//  Created by 森祐樹 on 2024/10/27.
//

import SwiftUI

struct PrefectureCardView: View {
    let prefecture: Prefecture
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image("\(prefecture)")
                .resizable()
                .frame(maxWidth: .infinity)
                .aspectRatio(contentMode: .fill)
                .frame(height: 100)
                .opacity(0.8)
                .overlay(alignment: .topLeading) {
                    Color.black
                        .opacity(0.2)
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))

            Text(prefecture.rawValue)
                .foregroundStyle(.white)
                .font(.system(size: 20))
                .bold()
                .padding(12)
        }
    }
}

#Preview {
    HStack {
        PrefectureCardView(prefecture: .tokushima)
        PrefectureCardView(prefecture: .ehime)
    }
}
