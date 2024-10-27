//
//  Region.swift
//  Tripper
//
//  Created by 森祐樹 on 2024/10/26.
//

import Foundation

enum JapaneseRegion: String, CaseIterable, Identifiable {
    case hokkaidoAndTohoku = "北海道・東北"
    case kanto = "関東"
    case chubu = "中部"
    case kansai = "関西"
    case chugoku = "中国"
    case shikoku = "四国"
    case kyushu = "九州"

    // id プロパティを rawValue から生成
    var id: String { return self.rawValue }
}

extension JapaneseRegion {
    var prefectures: [Prefecture] {
        switch self {
        case .hokkaidoAndTohoku: return [
                .hokkaido,
                .aomori,
                .iwate,
                .miyagi,
                .akita,
                .yamagata,
                .fukushima
            ]
        case .kanto: return [
                .ibaraki,
                .tochigi,
                .gunma,
                .saitama,
                .chiba,
                .tokyo,
                .kanagawa
            ]
        case .chubu: return [
                .niigata,
                .toyama,
                .ishikawa,
                .fukui,
                .yamanashi,
                .nagano,
                .gifu,
                .shizuoka,
                .aichi
            ]
        case .kansai: return [
                .mie,
                .shiga,
                .kyoto,
                .osaka,
                .hyogo,
                .nara,
                .wakayama
            ]
        case .chugoku: return [
                .tottori,
                .shimane,
                .okayama,
                .hiroshima,
                .yamaguchi
            ]
        case .shikoku: return [
                .tokushima,
                .kagawa,
                .ehime,
                .kochi
            ]
        case .kyushu: return [
                .fukuoka,
                .saga,
                .nagasaki,
                .kumamoto,
                .oita,
                .miyazaki,
                .kagoshima,
                .okinawa
            ]
        }
    }
}
