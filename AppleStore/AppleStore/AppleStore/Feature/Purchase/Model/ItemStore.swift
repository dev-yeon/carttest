//
//  ItemStore.swift
//  AppleStore
//
//  Created by SIKim on 2023/09/09.
//

import Foundation
import FirebaseFirestore

class ItemStore: ObservableObject {
    ///카탈로그 (전체 아이템 목록)
    @Published var items: [Item] = dummyitems
    //아이템 타입이 무엇
    @Published var seriesName : String?
    //타입 설정
    @Published var productName: String?
    //색상 설정
    @Published var productColor: String?
    //스토리지
    @Published var storage: String?
    //셀룰러
    @Published var embedCellular: String?
    
    @Published var productNameSet: Set<String> = []
    @Published var productColorSet: Set<String> = []
    @Published var storageSet: Set<String> = []
    @Published var embedCellularSet: Set<String> = []
    
//    var embedCellularString: String {
//        if let embedCellular {
//            return embedCellular
//        }
//        return ""
//    }
    
    //연산 프로퍼티로 사용자가 선택 할 수록 아이템에 필터 걸기
    var selectedItems : [Item] {
        var tempType = items
        if let seriesName {
            tempType = tempType.filter { $0.seriesName == seriesName }
            tempType.sort { $0.price < $1.price }
        }
        if let productName {
            tempType = tempType.filter { $0.productName == productName }
        }
        if let productColor {
            tempType = tempType.filter { $0.productColor == productColor }
        }
        if let storage {
            tempType = tempType.filter { $0.storage == storage }
        }
        if let embedCellular {
            tempType = tempType.filter { $0.embedCellular == embedCellular }
        }
        return tempType
    }
    
    func buttonInitializer() {
        //        let tempStruct = selectedItems
        
        ///객체로 접근
        for item in selectedItems {
            productNameSet.insert(item.productName)
            productColorSet.insert(item.productColor)
            storageSet.insert(item.storage)
            if let temp = item.embedCellular {
                embedCellularSet.insert(temp)
            }
        }
        
        //        print("\(productNaemSet)")
        //        print("\(productColorSet)")
        //        print("\(storageSet)")
        //        print("\(embedCellularSet)")
        
        for productName in productNameSet.sorted() {
            print(productName)
        }
        
        for productColor in productColorSet.sorted() {
            print(productColor)
        }
        
        for storage in storageSet.sorted() {
            print(storage)
        }
        
        for embedCellular in embedCellularSet.sorted() {
            print(embedCellular)
        }
    }
    
    func fetchItems() {
        let collectionReference = Firestore.firestore().collection("ItemInfo")
        
        items = []
        
        collectionReference.getDocuments { snapshot, error in
            if let error {
                print(#fileID, #function, #line, "- \(error) ")
            } else if let snapshot {
                var tempItems: [Item] = []
                
                for document in snapshot.documents {
                    let documentData: [String: Any] = document.data()
                    
                    let itemType: String = documentData["itemType"] as? String ?? "-"
                    let seriesName: String = documentData["seriesName"] as? String ?? "-"
                    let productName: String = documentData["productName"] as? String ?? "-"
                    let price: Int = documentData["price"] as? Int ?? 0
                    let mainImageString: String = documentData["mainImageString"] as? String ?? "-"
                    let productColor: String = documentData["productColor"] as? String ?? "-"
                    let storage: String = documentData["storage"] as? String ?? "-"
                    let status: Int = documentData["status"] as? Int ?? 0
                    let description: String = documentData["description"] as? String ?? "-"
                    let embedCellular: String? = documentData["embedCellular"] as? String
                    
                    let itemData: Item = Item(itemType: itemType, seriesName: seriesName, productName: productName, price: price, mainImageString: mainImageString, productColor: productColor, storage: storage, status: status, description: description, embedCellular: embedCellular)
                    
                    tempItems.append(itemData)
//                    print("데이터 -> 템프 : \(tempItems)")
                }
                
                self.items = tempItems
                print("템프 -> 아이템즈 : \(self.items)\n")
                print("개수 : \(self.items.count)")
            }
        }
    }
}

//extension String {
//    var getNameColor: [String] {
//        let components = self.split(separator: "/").map { String($0) }
//
//        var returnValue = components.isEmpty ? [""] : components
//
//        //무조건 2개의 값을 만들어서 런타임에러 방지 ㅋㅎ
//        for index in 0..<2 {
//            //값이 있으면 패스 없으면 넣어준다.
//            if !returnValue.indices.contains(index) {
//                returnValue.insert("", at: index)
//            }
//        }
//
//        //        print("reee \(returnValue)")
//
//        return returnValue
//    }
//}
