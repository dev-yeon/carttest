//
//  Product.swift
//  AppleStore
//
//  Created by KangHo Kim on 2023/09/11.
//

import Foundation


/// 개별 제품
struct Product: Identifiable {
    
    let id: String = UUID().uuidString // 고유 Product id값
    let name: String // 상품 이름
    let description: String // 상품 간단한 정보
    let price: Int // (시작가 및 가격)
    /// 배너 이미지 주소
    let imageURLString: String
    /// 상세 페이지 웹뷰 URL
    let detailWebURLString: String
}


