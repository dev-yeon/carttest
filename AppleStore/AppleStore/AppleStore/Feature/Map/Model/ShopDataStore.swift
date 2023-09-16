//
//  ShopDataStore.swift
//  AppleStore
//
//  Created by 김효석 on 2023/09/11.
//

import Foundation
import FirebaseFirestore

final class ShopDataStore: ObservableObject {
    
    @Published var shopDatas: [ShopModel] = []
        
    func fetchShopDatas() {
        let collectionReference = Firestore.firestore().collection("Shops")

        self.shopDatas = []

        collectionReference.getDocuments { snapshot, error in
            if let error {
                print(#fileID, #function, #line, "- \(error) ")
            } else if let snapshot {
                var tempShopDatas: [ShopModel] = []
                
                for document in snapshot.documents {
                    let documentData: [String: Any] = document.data()

                    let shopName: String = documentData["shopName"] as? String ?? "-"
                    let city: String = documentData["city"] as? String ?? "-"
                    let imageURLString: String = documentData["imageURLString"] as? String ?? "-"
                    let address: String = documentData["address"] as? String ?? "-"
                    let detailedAddress: String = documentData["detailedAddress"] as? String ?? "-"
                    let latitude: Double = documentData["latitude"] as? Double ?? 0.0
                    let longitude: Double = documentData["longitude"] as? Double ?? 0.0
                    let phoneNumber: String = documentData["phoneNumber"] as? String ?? "-"
                    let hours: [String] = documentData["hours"] as? [String] ?? ["-"]
                    let postCode: String = documentData["postCode"] as? String ?? "-"
                    let shopInformation: String = documentData["shopInformation"] as? String ?? "-"
                    
                    let shopData: ShopModel = ShopModel(shopName: shopName, city: city, imageURLString: imageURLString, address: address, detailedAddress: detailedAddress, latitude: latitude, longitude: longitude, phoneNumber: phoneNumber, hours: hours, postCode: postCode, shopInformation: shopInformation)
                    
                    tempShopDatas.append(shopData)
                }
                
                self.shopDatas = tempShopDatas
            }
        }
    }
    
    init() { }
    
    func getWeekdayInt() -> Int {
        let calendar = Calendar.current
        let today = Date()
        let components = calendar.dateComponents([.weekday], from: today)
        let weekday = (components.weekday! + 5) % 7
        
        return weekday
    }
    
    func sortShopsByDistance(_ shopDatas: [ShopModel]) -> [ShopModel] {
        let sortedDatas = shopDatas.sorted { (shopData1, shopData2) -> Bool in
            let distance1 = Double(MapCoordinator.shared.distancePresentToDestination(shopData1.latitude, shopData1.longitude)) ?? 0
            let distance2 = Double(MapCoordinator.shared.distancePresentToDestination(shopData2.latitude, shopData2.longitude)) ?? 0
            
            return distance1 < distance2
        }
        
        return sortedDatas
    }
}
