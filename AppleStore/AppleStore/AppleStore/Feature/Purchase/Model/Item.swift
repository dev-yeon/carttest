//
//  Item.swift
//  AppleStore
//
//  Created by SIKim on 2023/09/08.
//

import Foundation

struct Item: Identifiable, Codable {
    var id: String = UUID().uuidString              // 시리즈별 아이템의 고유 식별자 (ItemID)
    var itemType: String
    var seriesName: String                  //아이폰 시리즈 이름 예: iPhone 14  / iPhone 14 Pro [프로라인업]  //  ->> 등록할때 정해진 값을 선택하게 할 것임. (직접치지 않음) 서버에서 불러옴
    var productName: String                 //아이폰 시리즈 내의 제품들 예: iPhone 14, iPhone 14Plus   // ->> 직접 입력
    var price: Int                           //제품들 옵션에 따른 가격들, Int로 쓸지 String으로 쓸지 체크
    var mainImageString: String            //구매페이지에서 먼저 보이는 이미지들, 옵션 선택마다 이미지가 바뀌어서 배열로 일단 뒀음
    var productColor: String                 //시리즈에 따른 색상들   //  ->> 등록할때 정해진 값을 선택하게 할 것임. (직접치지 않음)
    var storage: String                       //저장용량들, Int로 할지 String으로 할지 체크  //  ->> 등록할때 정해진 값을 선택하게 할 것임. (직접치지 않음)
    var status : Int         // 0 문제 없음, 1 단종됨, 일시 품절  2. 판매 삭제 3. 신제품류   //  ->> 등록할때 정해진 값을 선택하게 할 것임. (직접치지 않음)
    var description: String
    var embedCellular: String?
}

let dummyitems = [
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro",
        price: 2300000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-1inch-deeppurple?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703840578",
        productColor: "딥 퍼플",
        storage: "1TB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro",
        price: 2000000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-1inch-deeppurple?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703840578",
        productColor: "딥 퍼플",
        storage: "512GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro",
        price: 1700000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-1inch-deeppurple?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703840578",
        productColor: "딥 퍼플",
        storage: "256GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro",
        price: 1550000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-1inch-deeppurple?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703840578",
        productColor: "딥 퍼플",
        storage: "128GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro",
        price: 1550000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-1inch-gold?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703840519",
        productColor: "골드",
        storage: "128GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro",
        price: 1700000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-1inch-gold?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703840519",
        productColor: "골드",
        storage: "256GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro",
        price: 2000000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-1inch-gold?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703840519",
        productColor: "골드",
        storage: "512GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro",
        price: 2300000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-1inch-gold?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703840519",
        productColor: "골드",
        storage: "1TB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro",
        price: 1550000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-1inch-silver?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703840488",
        productColor: "실버/#D6D6D6",
        storage: "128GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro",
        price: 1700000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-1inch-silver?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703840488",
        productColor: "실버/#D6D6D6",
        storage: "256GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro",
        price: 2000000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-1inch-silver?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703840488",
        productColor: "실버/#D6D6D6",
        storage: "512GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro",
        price: 2300000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-1inch-silver?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703840488",
        productColor: "실버/#D6D6D6",
        storage: "1TB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro",
        price: 1550000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-1inch-spaceblack?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703840510",
        productColor: "스페이스 블랙",
        storage: "128GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro",
        price: 1700000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-1inch-spaceblack?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703840510",
        productColor: "스페이스 블랙",
        storage: "256GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro",
        price: 2000000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-1inch-spaceblack?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703840510",
        productColor: "스페이스 블랙",
        storage: "512GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro",
        price: 2300000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-1inch-spaceblack?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703840510",
        productColor: "스페이스 블랙",
        storage: "1TB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro Max",
        price: 1750000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-7inch-deeppurple?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703841896",
        productColor: "딥 퍼플",
        storage: "128GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro Max",
        price: 1900000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-7inch-deeppurple?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703841896",
        productColor: "딥 퍼플",
        storage: "256GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro Max",
        price: 2200000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-7inch-deeppurple?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703841896",
        productColor: "딥 퍼플",
        storage: "512GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro Max",
        price: 2500000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-7inch-deeppurple?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703841896",
        productColor: "딥 퍼플",
        storage: "1TB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro Max",
        price: 1750000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-7inch-gold?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703841907",
        productColor: "골드",
        storage: "128GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro Max",
        price: 1900000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-7inch-gold?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703841907",
        productColor: "골드",
        storage: "256GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro Max",
        price: 2200000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-7inch-gold?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703841907",
        productColor: "골드",
        storage: "512GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro Max",
        price: 2500000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-7inch-gold?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703841907",
        productColor: "골드",
        storage: "1TB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro Max",
        price: 1750000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-7inch-silver?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703841892",
        productColor: "실버/#D6D6D6",
        storage: "128GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro Max",
        price: 1900000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-7inch-silver?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703841892",
        productColor: "실버/#D6D6D6",
        storage: "256GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro Max",
        price: 2200000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-7inch-silver?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703841892",
        productColor: "실버/#D6D6D6",
        storage: "512GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro Max",
        price: 2500000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-7inch-silver?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703841892",
        productColor: "실버/#D6D6D6",
        storage: "1TB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro Max",
        price: 1750000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-7inch-spaceblack?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703841897",
        productColor: "스페이스 블랙",
        storage: "128GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro Max",
        price: 1900000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-7inch-spaceblack?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703841897",
        productColor: "스페이스 블랙",
        storage: "256GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro Max",
        price: 2200000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-7inch-spaceblack?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703841897",
        productColor: "스페이스 블랙",
        storage: "512GB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPhone",
        seriesName: "iPhone 14 Pro",
        productName: "iPhone 14 Pro Max",
        price: 2500000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-7inch-spaceblack?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703841897",
        productColor: "스페이스 블랙",
        storage: "1TB",
        status: 3,
        description: ""
    ),
    Item(
        itemType: "iPad",
        seriesName: "iPad Air",
        productName: "iPad Air",
        price: 929000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-storage-select-202207-space-gray?wid=2560&hei=1440&fmt=p-jpg&qlt=95&.v=1654903003209",
        productColor: "스페이스 그레이",
        storage: "64GB",
        status: 0,
        description: "",
        embedCellular: "Wi-Fi"
    ),
    Item(
        itemType: "iPad",
        seriesName: "iPad Air",
        productName: "iPad Air",
        price: 929000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-finish-select-gallery-202211-starlight?wid=2560&hei=1440&fmt=p-jpg&qlt=95&.v=1667585247381",
        productColor: "스타라이트",
        storage: "64GB",
        status: 0,
        description: "",
        embedCellular: "Wi-Fi"
    ),
    Item(
        itemType: "iPad",
        seriesName: "iPad Air",
        productName: "iPad Air",
        price: 929000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-finish-select-gallery-202211-blue?wid=2560&hei=1440&fmt=p-jpg&qlt=95&.v=1666991953754",
        productColor: "블루",
        storage: "64GB",
        status: 0,
        description: "",
        embedCellular: "Wi-Fi"
    ),
    Item(
        itemType: "iPad",
        seriesName: "iPad Air",
        productName: "iPad Air",
        price: 929000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-finish-select-gallery-202211-pink?wid=2560&hei=1440&fmt=p-jpg&qlt=95&.v=1666991954257",
        productColor: "핑크",
        storage: "64GB",
        status: 0,
        description: "",
        embedCellular: "Wi-Fi"
    ),
    Item(
        itemType: "iPad",
        seriesName: "iPad Air",
        productName: "iPad Air",
        price: 929000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-finish-select-gallery-202211-purple?wid=2560&hei=1440&fmt=p-jpg&qlt=95&.v=1667585247674",
        productColor: "퍼플",
        storage: "64GB",
        status: 0,
        description: "",
        embedCellular: "Wi-Fi"
    ),
    Item(
        itemType: "iPad",
        seriesName: "iPad Air",
        productName: "iPad Air",
        price: 1169000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-storage-select-202207-space-gray?wid=2560&hei=1440&fmt=p-jpg&qlt=95&.v=1654903003209",
        productColor: "스페이스 그레이",
        storage: "64GB",
        status: 0,
        description: "",
        embedCellular: "Wi-Fi + Cellular"
    ),
    Item(
        itemType: "iPad",
        seriesName: "iPad Air",
        productName: "iPad Air",
        price: 1169000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-finish-select-gallery-202211-starlight?wid=2560&hei=1440&fmt=p-jpg&qlt=95&.v=1667585247381",
        productColor: "스타라이트",
        storage: "64GB",
        status: 0,
        description: "",
        embedCellular: "Wi-Fi + Cellular"
    ),
    Item(
        itemType: "iPad",
        seriesName: "iPad Air",
        productName: "iPad Air",
        price: 1169000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-finish-select-gallery-202211-blue?wid=2560&hei=1440&fmt=p-jpg&qlt=95&.v=1666991953754",
        productColor: "블루",
        storage: "64GB",
        status: 0,
        description: "",
        embedCellular: "Wi-Fi + Cellular"
    ),
    Item(
        itemType: "iPad",
        seriesName: "iPad Air",
        productName: "iPad Air",
        price: 1169000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-finish-select-gallery-202211-pink?wid=2560&hei=1440&fmt=p-jpg&qlt=95&.v=1666991954257",
        productColor: "핑크",
        storage: "64GB",
        status: 0,
        description: "",
        embedCellular: "Wi-Fi + Cellular"
    ),
    Item(
        itemType: "iPad",
        seriesName: "iPad Air",
        productName: "iPad Air",
        price: 1169000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-finish-select-gallery-202211-purple?wid=2560&hei=1440&fmt=p-jpg&qlt=95&.v=1667585247674",
        productColor: "퍼플",
        storage: "64GB",
        status: 0,
        description: "",
        embedCellular: "Wi-Fi + Cellular"
    ),
    Item(
        itemType: "iPad",
        seriesName: "iPad Air",
        productName: "iPad Air",
        price: 1169000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-storage-select-202207-space-gray?wid=2560&hei=1440&fmt=p-jpg&qlt=95&.v=1654903003209",
        productColor: "스페이스 그레이",
        storage: "256GB",
        status: 0,
        description: "",
        embedCellular: "Wi-Fi"
    ),
    Item(
        itemType: "iPad",
        seriesName: "iPad Air",
        productName: "iPad Air",
        price: 1169000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-finish-select-gallery-202211-starlight?wid=2560&hei=1440&fmt=p-jpg&qlt=95&.v=1667585247381",
        productColor: "스타라이트",
        storage: "256GB",
        status: 0,
        description: "",
        embedCellular: "Wi-Fi"
    ),
    Item(
        itemType: "iPad",
        seriesName: "iPad Air",
        productName: "iPad Air",
        price: 1169000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-finish-select-gallery-202211-blue?wid=2560&hei=1440&fmt=p-jpg&qlt=95&.v=1666991953754",
        productColor: "블루",
        storage: "256GB",
        status: 0,
        description: "",
        embedCellular: "Wi-Fi"
    ),
    Item(
        itemType: "iPad",
        seriesName: "iPad Air",
        productName: "iPad Air",
        price: 1169000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-finish-select-gallery-202211-pink?wid=2560&hei=1440&fmt=p-jpg&qlt=95&.v=1666991954257",
        productColor: "핑크",
        storage: "256GB",
        status: 0,
        description: "",
        embedCellular: "Wi-Fi"
    ),
    Item(
        itemType: "iPad",
        seriesName: "iPad Air",
        productName: "iPad Air",
        price: 1169000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-finish-select-gallery-202211-purple?wid=2560&hei=1440&fmt=p-jpg&qlt=95&.v=1667585247674",
        productColor: "퍼플",
        storage: "256GB",
        status: 0,
        description: "",
        embedCellular: "Wi-Fi"
    ),
    Item(
        itemType: "iPad",
        seriesName: "iPad Air",
        productName: "iPad Air",
        price: 1409000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-storage-select-202207-space-gray?wid=2560&hei=1440&fmt=p-jpg&qlt=95&.v=1654903003209",
        productColor: "스페이스 그레이",
        storage: "256GB",
        status: 0,
        description: "",
        embedCellular: "Wi-Fi + Cellular"
    ),
    Item(
        itemType: "iPad",
        seriesName: "iPad Air",
        productName: "iPad Air",
        price: 1409000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-finish-select-gallery-202211-starlight?wid=2560&hei=1440&fmt=p-jpg&qlt=95&.v=1667585247381",
        productColor: "스타라이트",
        storage: "256GB",
        status: 0,
        description: "",
        embedCellular: "Wi-Fi + Cellular"
    ),
    Item(
        itemType: "iPad",
        seriesName: "iPad Air",
        productName: "iPad Air",
        price: 1409000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-finish-select-gallery-202211-blue?wid=2560&hei=1440&fmt=p-jpg&qlt=95&.v=1666991953754",
        productColor: "블루",
        storage: "256GB",
        status: 0,
        description: "",
        embedCellular: "Wi-Fi + Cellular"
    ),
    Item(
        itemType: "iPad",
        seriesName: "iPad Air",
        productName: "iPad Air",
        price: 1409000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-finish-select-gallery-202211-pink?wid=2560&hei=1440&fmt=p-jpg&qlt=95&.v=1666991954257",
        productColor: "핑크",
        storage: "256GB",
        status: 0,
        description: "",
        embedCellular: "Wi-Fi + Cellular"
    ),
    Item(
        itemType: "iPad",
        seriesName: "iPad Air",
        productName: "iPad Air",
        price: 1409000,
        mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-finish-select-gallery-202211-purple?wid=2560&hei=1440&fmt=p-jpg&qlt=95&.v=1667585247674",
        productColor: "퍼플",
        storage: "256GB",
        status: 0,
        description: "",
        embedCellular: "Wi-Fi + Cellular"
    ),
]
