//
//  ShopModel.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/06.
//

import Foundation

///매장 모델
public struct ShopModel: Identifiable {
    public let id: String = UUID().uuidString
    /// 상점 이름
    public let shopName: String
    /// 도시
    public let city: String
    /// 이미지 url
    public let imageURLString: String
    /// 주소
    public let address: String
    /// 상세주소
    public let detailedAddress: String
    /// 위도 (지도 설정을 위한 값)
    public let latitude: Double
    /// 경도
    public let longitude: Double
    /// 가게 전화번호
    public let phoneNumber: String
    /// 영업 시간 [월 - 일] 0 : 월 6 : 일
    public let hours: [String]
    /// 우편번호
    public let postCode: String
    /// 가게 상세정보
    public let shopInformation: String
}
//    var imageURL: URL? {
//        URL(string: imageURLString)
//    }
    
    // 찜 및 관심 스토어 설정
//}
