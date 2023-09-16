//
//  ProductsCategory.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/06.
//

import Foundation

// 제품별로 쇼핑하기 부분의 대분류
public struct ProductsCategory: Identifiable {
    /// 대분류 id 값
    public let id: String = UUID().uuidString
    /// 분류 명
    public let name: String
    /// 분류 대표 이미지 주소
    public let imageURLString: String
    var imageURL: URL {
        get {
            return URL(string: imageURLString)!
        }
    }
    /// 제품의 배열 값
    public var products: [Product]
    // var accessories: [Accessory]
}

public struct Accessory: Identifiable {
    public let id: String = UUID().uuidString
    public let name: String
    /// SF Symbol 사용하면 될듯
    public let imageName: String
}
