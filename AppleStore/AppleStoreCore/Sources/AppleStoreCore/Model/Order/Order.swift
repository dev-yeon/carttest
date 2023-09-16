//
//  Order.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/06.
//

import Foundation

public struct Order: Identifiable, Codable, Hashable {
    public var id: String = UUID().uuidString
    /// 주문한 유저 id
    public var uid: String
    /// 상품명
    public var productName : String
    /// 가격
    public var price: Int
    /// 6가지 : 입금 대기, 결제 완료, 상품 준비중, 상품 발송, 구매 확정, 주문 취소
    public var state: String
    /// 이미지
    public var imageURLString: String
    /// 결제정보 id
    public var paymentId: String
    
    // + Address 하위 컬렉션 (좋다.)
    /// 우편번호
    public var prostal: String?
    /// 주소
    public var headAddress: String?
    /// 상세주소
    public var detailAddress: String?
    /// 국가
    public var nation: String?           // 국가
    /// 핸드폰
    public var phone: String?
    /// 언제 주문 들어왔는지!
    public var createdAt: Double
    /// 운송 회사 (CJ 같은)
    public var deliveryServiceCompany: String?
    /// 운송장 번호
    public var trackingNumber: String? 
}
