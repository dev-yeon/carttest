//
//  IPhoneSeries.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/06.
//

import Foundation

public struct ItemInfo: Identifiable, Codable, Hashable {
    /// 시리즈별 아이템의 고유 식별자 (ItemID)
    public let id: String
    /// 물품 타입
    public let itemType: String
    ///아이폰 시리즈 이름 예: iPhone 14  / iPhone14 Pro [프로라인업]  //
    /// ->> 등록할때 정해진 값을 선택하게 할 것임. (직접치지 않음) 서버에서 불러옴
    public var seriesName: String
    ///아이폰 시리즈 내의 제품들 예: iPhone 14, iPhone 14Plus   // ->> 직접 입력
    public var productName: String
    ///제품 부연설명
    public var description: String
    ///제품들 옵션에 따른 가격들, Int로 쓸지 String으로 쓸지 체크
    public var price: String
    ///구매페이지에서 먼저 보이는 이미지들, 옵션 선택마다 이미지가 바뀌어서 배열로 일단 뒀음
    public var mainImageString: String
    ///시리즈에 따른 색상들   //  ->> 등록할때 정해진 값을 선택하게 할 것임. (직접치지 않음)
    public var productColor: String
    ///저장용량들, Int로 할지 String으로 할지 체크  //  ->> 등록할때 정해진 값을 선택하게 할 것임. (직접치지 않음)
    public var storage: String
    /// 0 문제 없음, 1 단종됨, 일시 품절  2. 판매 삭제 3. 신제품류   //  ->> 등록할때 정해진 값을 선택하게 할 것임. (직접치지 않음)
    public var status: Int
    ///아이패드만 적용 wifi모델, lte모델 여부
    public var embedCellular: String?
    
    
    public init(id: String = UUID().uuidString, itemType: String, seriesName: String, productName: String, description: String, price: String, mainImageString: String, productColor: String, storage: String, status: Int, embedCellular: String? = nil) {
        self.id = id
        self.itemType = itemType
        self.seriesName = seriesName
        self.productName = productName
        self.description = description
        self.price = price
        self.mainImageString = mainImageString
        self.productColor = productColor
        self.storage = storage
        self.status = status
        self.embedCellular = embedCellular
    }
    
}


///제품별 카테고리
public struct Kind: Identifiable, Codable {
    ///DocumentID는 import FirebaseFirestoreSwift 하면 가능
    ///id가 필드가 아닌 문서번호로 해석됩니다.
    public let id: String
    public let itemType: String           //아이폰, 아이패드
    public var storages: [String]?        //용량
    public var colors: [String]?          //색상
    public var series: [String]?          //시리즈
    public var embedCellulars: [String]?  //셀룰러여부
    
    //23.09.12 신우진 Kind 초기화시 Decode 생략을 위한 init함수 추가
    public init(id: String = UUID().uuidString, itemType: String, storages: [String]? = nil, colors: [String]? = nil, series: [String]? = nil, embedCellulars: [String]? = nil) {
        self.id = id
        self.itemType = itemType
        self.storages = storages
        self.colors = colors
        self.series = series
        self.embedCellulars = embedCellulars
    }
    
}
