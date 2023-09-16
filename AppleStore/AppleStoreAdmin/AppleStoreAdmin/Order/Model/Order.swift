//
//  Order.swift
//  AppleStoreAdmin
//
//  Created by 김유진 on 2023/09/05.
//

import Foundation
import AppleStoreCore

enum OrderStatus: String, Equatable, CaseIterable, Codable {
    case complete = "구매 확정"
    case receipt = "입금 대기"
    case payment = "결제 완료"
    case prepare = "상품 준비중"
    case shipment = "상품 발송"
    case cancle = "주문 취소"
}

enum deliveryServiceCompanies: String, Equatable, CaseIterable, Codable {
    case cj = "CJ대한통운"
    case logen = "로젠택배"
    case epost = "우체국택배"
    case hanjin = "한진택배"
    case lotte = "롯데택배"
    case ilyangLogis = "일양로지스"
}

extension Order {
    var createdOrder: String {
        let dateCreatedAt: Date = Date(timeIntervalSince1970: createdAt)

        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "YY년 MM월 dd일 HH시 mm분"

        return dateFormatter.string(from: dateCreatedAt)
    }
}
