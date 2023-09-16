//
//  ProductCategory.swift
//  AppleStore
//
//  Created by KangHo Kim on 2023/09/11.
//

import Foundation

/// 제품별로 쇼핑하기 부분의 대분류
struct ProductsCategory: Identifiable {
    let id: String = UUID().uuidString // 대분류 id 값
    let name: String // 분류 명
    let imageURLString: String // 분류 대표 이미지 주소
    var products: [Product] // 제품의 배열 값
    // var accessories: [Accessory] // 2주차 경과 보고 진행 (추가사항)
}
