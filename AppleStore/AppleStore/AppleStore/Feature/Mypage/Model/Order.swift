//
//  Order.swift
//  AppleStore
//
//  Created by dayexx on 2023/09/05.
//

import Foundation

struct Order: Identifiable, Codable {
    var id: String = UUID().uuidString
    var uid: String           // 주문한 유저 id
    var productName : String     // 상품명
    var price: Int               // 가격
    
    // 6가지 : 입금 대기, 결제 완료, 상품 준비중, 상품 발송, 구매 확정, 주문 취소
    var state: String = "입금 대기"
    var imageURLString: String   // 이미지
    var paymentId: String   // 결제정보 id
    
    // + Address 하위 컬렉션 (좋다.)
    var prostal: String?      // 우편번호
    var headAddress: String?      // 주소
    var detailAddress: String?   // 상세주소
    var nation: String?           // 국가
    var phone: String?            // 핸드폰
    
    var createdAt: Double // 언제 주문 들어왔는지!
    var createdDate: String {
        let dateCreatedAt: Date = Date(timeIntervalSince1970: createdAt)
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        
        return dateFormatter.string(from: dateCreatedAt)
    }
    
    var deliveryServiceCompany: String? // 운송 회사 CJ 같은
    var trackingNumber: String? // 운송장 번호
}

