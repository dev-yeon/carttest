//
//  Cart.swift
//  
//
//  Created by cha_nyeong on 2023/09/12.
//

import Foundation

///장바구니 모델
public struct Cart {
    ///장바구니 id값
    public var id: String = UUID().uuidString
    ///사용자 uid
    public let uid: String
    ///장바구니 상품 배열
    public var cartItems: [CartItem]
}
