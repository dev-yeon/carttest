//
//  ShopModel.swift
//  AppleStore
//
//  Created by 김효석 on 2023/09/11.
//

import Foundation

struct ShopModel: Identifiable {
    let id: String = UUID().uuidString
    let shopName: String      // 상점 이름
    let city: String          // 도시
    let imageURLString: String  // 이미지 url
    let address: String       // 주소
    let detailedAddress: String // 상세주소
    let latitude: Double      // 위도 (지도 설정을 위한 값)
    let longitude: Double     // 경도
    let phoneNumber: String   // 가게 전화번호
    let hours: [String]       // 영업 시간 [월 - 일] 0 : 월 6 : 일
    let postCode: String      // 우편번호
    let shopInformation: String  // 가게 상세정보
}


extension ShopModel {
    static let sampleData: [Self] = [
        ShopModel(shopName: "가로수길", city: "서울", imageURLString: "https://rtlimages.apple.com/cmc/dieter/store/16_9/R692.png?resize=2880:1612&output-format=jpg&output-quality=85&interpolation=progressive-bicubic", address: "서울 강남구 가로수길 43", detailedAddress: "", latitude: 37.5208303, longitude: 127.022570, phoneNumber: "080-500-0029", hours: ["10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후"], postCode: "06028" ,shopInformation: "Apple 가로수길은 패션과 문화의 거리, 가로수길의 중간 쯤에 위치해 있습니다. 압구정로 12길과 도산대로 13길이 만나는 지점에 가깝죠. 주차공간이 여의치 않으므로 대중교통을 이용하시길 바랍니다. 대중교통편: 지하철 3호선 신사역 8번 출구에서 도보로 10분 거리입니다. 주변에 버스정류장도 있습니다."),
        ShopModel(shopName: "잠실", city: "서울", imageURLString: "https://digitalassets-retail.cdn-apple.com/retail-image-server/8f8/32b/370/1c2/990/11c/19d/dcd/645/124/5df05571-db28-3987-b6bb-f5601c571821_Apple_Jamsil_large_2x.png", address: "서울 송파구 올림픽로 300", detailedAddress: "롯데월드몰 1F", latitude: 37.5135790, longitude: 127.104765, phoneNumber: "080-500-0098", hours: ["10:30 오전 - 10:00 오후", "10:30 오전 - 10:00 오후", "10:30 오전 - 10:00 오후", "10:30 오전 - 10:00 오후", "10:30 오전 - 10:00 오후", "10:30 오전 - 10:00 오후", "10:30 오전 - 10:00 오후"], postCode: "05551", shopInformation: "Apple 가로수길은 패션과 문화의 거리, 가로수길의 중간 쯤에 위치해 있습니다. 압구정로 12길과 도산대로 13길이 만나는 지점에 가깝죠. 주차공간이 여의치 않으므로 대중교통을 이용하시길 바랍니다. 대중교통편: 지하철 3호선 신사역 8번 출구에서 도보로 10분 거리입니다. 주변에 버스정류장도 있습니다."),
        ShopModel(shopName: "명동", city: "서울", imageURLString: "https://digitalassets-retail.cdn-apple.com/retail-image-server/aa9/6b9/ef4/ec8/7e6/414/d44/320/d9a/1a6/3e519f29-53d9-3e8e-88c9-c433462f4b42_Myeongdong_20220409_TF_Store_Page_large_2x.jpg", address: "서울 중구 남대문로 2가 9-1", detailedAddress: "하이드파크" ,latitude: 37.5646641, longitude: 126.982820, phoneNumber: "080-500-1007", hours: ["10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후"], postCode: "04534", shopInformation: "Apple 명동은 명동 쇼핑 중심지 내 남대문로에 위치해 있으며, 롯데백화점을 바로 맞은 편에 두고 있습니다. 주차 공간이 여의치 않으므로 대중교통을 이용하시길 바랍니다. 대중교통편: 지하철 2호선 을지로역 6번 출구에서 하차하시면 됩니다."),
        ShopModel(shopName: "강남", city: "서울", imageURLString: "https://rtlimages.apple.com/cmc/dieter/store/16_9/R691.png?resize=2880:1612&output-format=jpg&output-quality=85&interpolation=progressive-bicubic", address: "서울 강남구 강남대로 464", detailedAddress: "", latitude: 37.5039000, longitude: 127.025212, phoneNumber: "080-500-0456", hours: ["10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후"], postCode: "06123", shopInformation: "Apple 잠실은 송파구 롯데월드몰에 위치해 있습니다. 잠실로 또는 올림픽로를 통해 오실 수 있으며, 쇼핑몰 내에 주차가 가능합니다. 대중교통편: 지하철 2호선 또는 8호선 잠실역 (10 번 혹은 11번 출구) 하차 후 롯데월드몰 방면으로 오시면 됩니다. 근방에 지선버스(초록), 간선버스(파랑), 광역버스, 공항버스를 포함한 다양한 종류의 버스가 정차합니다."),
        ShopModel(shopName: "여의도", city: "서울", imageURLString: "https://digitalassets-retail.cdn-apple.com/retail-image-server/91e/64b/a4c/e1f/ebf/c65/f89/f5d/258/d55/7688a9a4-db22-373b-b63c-ca23c5e2adea_Yeouido_20210226_TF_RetailStorePage_large_2x.jpg", address: "서울 영등포구 국제금융로 10", detailedAddress: "IFC MALL, L1", latitude: 37.5249613, longitude: 126.925282, phoneNumber: "080-500-0013", hours: ["10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후"], postCode: "07326", shopInformation: "Apple 여의도는 서울의 중심부인 영등포구 IFC몰 L1에 위치해 있습니다. 대중교통편: 지하철 5호선, 9호선이 만나는 여의도역에 하차하여 3번 출구 방향 IFC몰이 연결되어 있습니다. 주변에 다양한 버스 노선 및 버스정류장도 있으며. 주차공간은 IFC몰 유료 주차장을 이용하실 수 있습니다.")
    ]
}
