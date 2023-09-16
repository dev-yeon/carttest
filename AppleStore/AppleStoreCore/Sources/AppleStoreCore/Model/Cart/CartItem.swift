//
//  CartItem.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/06.
//

import Foundation


// MARK: 임시 모델
public struct CartItem: Identifiable, Codable {
    ///장바구니 아이템의 고유 식별자
    public var id: String = UUID().uuidString
    ///사용자 uid
    public let uid: String
    /// 상품 이름
    public let name: String // ex) 11형 iPad Pro Wi-Fi 1TB - 실버 / iPhone 14 Pro 1TB 딥 퍼플
    /// 상품 개별 가격
    public let price: Int
    /// 상품 수량 (고유 장바구니)
    public var amount: Int
    /// 체크아웃을 위해 아이템이 선택되었는지 여부
    public var isChecked: Bool
    /// 상품 이미지의 URL
    public var imageURL: URL
    /// 배송상태는 고정?   "익일 - 무료 배송"
    ///
    public init(id: String, uid: String, name: String, price: Int, amount: Int, isChecked: Bool, imageURL: URL) {
        self.id = id
        self.uid = uid
        self.name = name
        self.price = price
        self.amount = amount
        self.isChecked = isChecked
        self.imageURL = imageURL
    }
}

#if DEBUG
@available(macOS 10.15, *)
@available(iOS 13.0, *)
extension CartItem {
    public static var sampleCartItem: CartItem {
        CartItem(id: UUID().uuidString, uid: "yZqUtdcY1ofZ53vjkjU0VxVcObe2", name: "iPhone 14 Pro 128GB 딥 퍼플", price: 1550000, amount: 1, isChecked: false, imageURL: URL(string: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-deeppurple-select?wid=800&hei=800&fmt=jpeg&qlt=90&fit=constrain&.v=1663364422362")!)
    }
}
#endif
