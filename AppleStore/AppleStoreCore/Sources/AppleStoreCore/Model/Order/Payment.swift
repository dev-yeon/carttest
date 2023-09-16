//
//  Payment.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/06.
//

import Foundation

///결제 모델
public struct Payment: Identifiable, Codable {
    ///결제 번호
    public var id: String = UUID().uuidString
    /// 유저 Id
    public let uid: String
    /// 지불 완료 시 (상태 값)/
    public var isPayed: Bool
    /// 가상 계좌 은행이름
    public let bankName: String
    /// 가상 계좌 번호
    public let bankAccountNumber: String
    /// 가격
    public let totalPrice: Int
    /// 발급일시
    public var createdAt: Double = Date().timeIntervalSince1970
    // 0. 주문 신청 1. 입금 확인중 2. 처리중 3. 입금 확인 4. 배송 진행
    // 위 주석 내용인 주문처리 프로세스 상태는 order 구조체로 넘김
}
