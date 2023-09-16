//
//  BookMark.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/06.
//

import Foundation

///찜 기능 모델
public struct BookMark {
    public var id: String = UUID().uuidString
    ///유저 id
    public var uid: String
    ///productId
    public var productName : String
    ///가격
    public var price: Int
    ///제품 이미지 URL
    public var imageURLString: String
}
