//
//  AppleShop.swift
//  AppleStoreAdmin
//
//  Created by 송성욱 on 2023/09/07.
//

import Foundation

struct ShopModel: Identifiable {
    var id: String = UUID().uuidString
    /// 상점 이름
    let shopName: String
    /// 도시
    let city: String
    /// 이미지 url
    let imageURLString: String
    /// 주소
    let address: String
    /// 상세주소
    let detailedAddress: String
    /// 위도 (지도 설정을 위한 값)
    let latitude: Double
    /// 경도
    let longitude: Double
    /// 가게 전화번호/
    let phoneNumber: String
    /// 영업 시간 [월 - 일] 0 : 월 6 : 일
    let hours: [String]
    /// 우편번호
    let postCode: String
    /// 가게 상세정보
    let shopInformation: String
}

