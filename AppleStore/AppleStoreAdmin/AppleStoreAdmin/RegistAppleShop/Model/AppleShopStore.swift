//
//  AppleShopStore.swift
//  AppleStoreAdmin
//
//  Created by 송성욱 on 2023/09/07.
//

import Foundation
import FirebaseFirestore

class ShopDataStore: ObservableObject {
    ///shopModel 들을 담는 배열
    @Published var shopDatas: [ShopModel] = []
    
    let sampleData = ShopModel(shopName: "Apple 가로수길", city: "서울", imageURLString: "https://rtlimages.apple.com/cmc/dieter/store/16_9/R692.png?resize=2880:1612&output-format=jpg&output-quality=85&interpolation=progressive-bicubic", address: "서울 강남구 가로수길 43", detailedAddress: "", latitude: 37.5208303, longitude: 127.022570, phoneNumber: "080-500-0029", hours: ["10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후", "10:00 오전 - 10:00 오후"], postCode: "06028" ,shopInformation: "Apple 가로수길은 패션과 문화의 거리, 가로수길의 중간 쯤에 위치해 있습니다. 압구정로 12길과 도산대로 13길이 만나는 지점에 가깝죠. 주차공간이 여의치 않으므로 대중교통을 이용하시길 바랍니다. 대중교통편: 지하철 3호선 신사역 8번 출구에서 도보로 10분 거리입니다. 주변에 버스정류장도 있습니다.")
    
    let dbRef = Firestore.firestore().collection("Shops")
    
    func fetchData() {
        
        dbRef.getDocuments { (snapshot, error) in
            self.shopDatas.removeAll()
            
            if let snapshot {
                
                var tempShopDatas: [ShopModel] = []
                
                for document in snapshot.documents {
                    
                    let id: String = document.documentID
                    
                    let docData: [String : Any] = document.data()
                    let shopName: String = docData["shopName"] as? String ?? "(no name)"
                    let city: String = docData["city"] as? String ?? ""
                    let imageURLString: String = docData["imageURLString"] as? String ?? "(no URL)"
                    let address: String = docData["address"] as? String ?? "(no address)"
                    let detailedAddress: String = docData["detailedAddress"] as? String ?? ""
                    let latitude: Double = docData["latitude"] as? Double ?? 0.0
                    let longitude: Double = docData["longitude"] as? Double ?? 0.0
                    let phoneNumber: String = docData["phoneNumber"] as? String ?? ""
                    let hours: [String] = docData["hours"] as? [String] ?? [""]
                    let postCode: String = docData["postCode"] as? String ?? ""
                    let shopInformation: String = docData["shopInformation"] as? String ?? ""
                    
                    let shop: ShopModel = ShopModel(id: id, shopName: shopName, city: city, imageURLString: imageURLString, address: address, detailedAddress: detailedAddress, latitude: latitude, longitude: longitude, phoneNumber: phoneNumber, hours: hours, postCode: postCode, shopInformation: shopInformation)
                    
                    tempShopDatas.append(shop)
                    
                }
                
                self.shopDatas = tempShopDatas
                
            }
        }
    }
    
    func addShop(id: String,shopName: String, city: String, imageURLString: String, address: String, detailedAddress: String, latitude: Double, longitude: Double, phoneNumber: String, hours: [String], postCode: String, shopInformation: String) {
        let shop: ShopModel = ShopModel(id: id, shopName: shopName, city: city, imageURLString: imageURLString, address: address, detailedAddress: detailedAddress, latitude: latitude, longitude: longitude, phoneNumber: phoneNumber, hours: hours, postCode: postCode, shopInformation: shopInformation)
        dbRef.document(shop.id)
            .setData(["shopName": shop.shopName,
                      "city": shop.city,
                      "imageURLString": shop.imageURLString,
                      "address": shop.address,
                      "detailedAddress": shop.detailedAddress,
                      "latitude": shop.latitude,
                      "longitude": shop.longitude,
                      "phoneNumber": shop.phoneNumber,
                      "hours": shop.hours,
                      "postCode": shop.postCode,
                      "shopInformation": shop.shopInformation
                     ])
        shopDatas.append(shop)
        fetchData()
    }
    
    func removeShop(at offsets: IndexSet) {
        for offset in offsets {
            let shop = shopDatas[offset]
            
            Firestore.firestore().collection("Shops")
                .document(shop.id)
                .delete()
        }
        shopDatas.remove(atOffsets: offsets)
        fetchData()
    }
}
