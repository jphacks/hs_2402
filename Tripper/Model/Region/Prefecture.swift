//
//  Prefecture.swift
//  Tripper
//
//  Created by 森祐樹 on 2024/10/26.
//

import Foundation

enum Prefecture: String, CaseIterable, Identifiable, Codable {
    // 北海道
    case hokkaido = "北海道"

    // 東北
    case aomori = "青森"
    case iwate = "岩手"
    case miyagi = "宮城"
    case akita = "秋田"
    case yamagata = "山形"
    case fukushima = "福島"

    // 関東
    case ibaraki = "茨城"
    case tochigi = "栃木"
    case gunma = "群馬"
    case saitama = "埼玉"
    case chiba = "千葉"
    case tokyo = "東京"
    case kanagawa = "神奈川"

    // 中部
    case niigata = "新潟"
    case toyama = "富山"
    case ishikawa = "石川"
    case fukui = "福井"
    case yamanashi = "山梨"
    case nagano = "長野"
    case gifu = "岐阜"
    case shizuoka = "静岡"
    case aichi = "愛知"

    // 関西
    case mie = "三重"
    case shiga = "滋賀"
    case kyoto = "京都"
    case osaka = "大阪"
    case hyogo = "兵庫"
    case nara = "奈良"
    case wakayama = "和歌山"

    // 中国
    case tottori = "鳥取"
    case shimane = "島根"
    case okayama = "岡山"
    case hiroshima = "広島"
    case yamaguchi = "山口"

    // 四国
    case tokushima = "徳島"
    case kagawa = "香川"
    case ehime = "愛媛"
    case kochi = "高知"

    // 九州
    case fukuoka = "福岡"
    case saga = "佐賀"
    case nagasaki = "長崎"
    case kumamoto = "熊本"
    case oita = "大分"
    case miyazaki = "宮崎"
    case kagoshima = "鹿児島"
    case okinawa = "沖縄"

    // id プロパティを rawValue から生成
    var id: String { return self.rawValue }
}

extension Prefecture {
    /*
     "都、府、県"を追加した名前を取得。
     北海道はそのままの文字列を返します。
    */
    var nameWithSuffix: String {
        switch self {
        case .hokkaido: return self.rawValue
        default: return self.rawValue + self.suffix
        }
    }

    var suffix: String {
        switch self {
        case .hokkaido     : return "道"
        case .tokyo        : return "都"
        case .kyoto, .osaka: return "府"
        default            : return "県"
        }
    }
}

