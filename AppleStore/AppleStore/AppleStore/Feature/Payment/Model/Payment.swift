//
//  Payment.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/07.
//

import Foundation

struct Payment: Identifiable, Codable {
    var id: String = UUID().uuidString //결제 번호
    let uid: String    // 유저 Id
    var isPayed: Bool     // 지불 완료 시 (상태 값)
                        // 0. 주문 신청 1. 입금 확인중 2. 처리중 3. 입금 확인 4. 배송 진행
    let bankName: String    // 가상 계좌 은행이름
    let bankAccountNumber: String   //가상 계좌 번호
    let totalPrice: Int       // 결제할 총 가격
    var createdAt: Double = Date().timeIntervalSince1970  // 발급일시
}
