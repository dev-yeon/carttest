//
//  Product.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/06.
//

import Foundation

public struct Product: Identifiable {
    /// 고유 Product id값
    public let id: String = UUID().uuidString
    /// 상품 이름
    public let name: String
    /// 상품 간단한 정보
    public let description: String
    /// 시작가 및 가격
    public let price: Int
    /// 배너 이미지
    public let imageURLString: String
    var imageURL: URL {
        get {
            return URL(string: imageURLString)!
        }
    } // 연산 프로퍼티 필요시 가져다 쓸것
    /// 상세 페이지 전용 이미지 주소 배열
    public var detailImageStrings: [String]?
}
