//
//  SearchViewModel.swift
//  AppleStore
//
//  Created by 박서연 on 2023/09/11.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

// 전체 제품 구조체
struct ItemInfo: Codable, Identifiable, Hashable {
    let id: String                          // 시리즈별 아이템의 고유 식별자 (ItemID)
        let itemType: String
        var seriesName: String              //아이폰 시리즈 이름 예: iPhone 14  / iPhone 14 Pro [프로라인업]  //  ->> 등록할때 정해진 값을 선택하게 할 것임. (직접치지 않음) 서버에서 불러옴
        var productName: String             //아이폰 시리즈 내의 제품들 예: iPhone 14, iPhone 14Plus   // ->> 직접 입력
        var description: String             //제품 부연설명
        var price: String                   //제품들 옵션에 따른 가격들, Int로 쓸지 String으로 쓸지 체크
        var mainImageString: String         //구매페이지에서 먼저 보이는 이미지들, 옵션 선택마다 이미지가 바뀌어서 배열로 일단 뒀음
        var productColor: String            //시리즈에 따른 색상들   //  ->> 등록할때 정해진 값을 선택하게 할 것임. (직접치지 않음)
        var storage: String                 //저장용량들, Int로 할지 String으로 할지 체크  //  ->> 등록할때 정해진 값을 선택하게 할 것임. (직접치지 않음)
        var status: Int                     // 0 문제 없음, 1 단종됨, 일시 품절  2. 판매 삭제 3. 신제품류   //  ->> 등록할때 정해진 값을 선택하게 할 것임. (직접치지 않음)
        var embedCellular: String = ""      //아이패드만 적용 wifi모델, lte모델 여부
        
        
        init(id: String = UUID().uuidString, itemType: String, seriesName: String, productName: String, description: String, price: String, mainImageString: String, productColor: String, storage: String, status: Int, embedCellular: String) {
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

// Kind 구조체
//struct Kind: Identifiable, Codable {
//    @DocumentID var id: String?    //id가 필드가 아닌 문서번호로 해석됩니다.
//    let itemType: String           //아이폰, 아이패드
//    var storages: [String]?        //용량
//    var colors: [String]?          //색상
//    var series: [String]?          //시리즈
//    var embedCellulars: [String]?  //셀룰러여부
//
//}

struct Kind: Identifiable, Codable {
    ///DocumentID는 import FirebaseFirestoreSwift 하면 가능
    ///id가 필드가 아닌 문서번호로 해석됩니다.
    public let id: String
    public let itemType: String           //아이폰, 아이패드
    public var storages: [String]?        //용량
    public var colors: [String]?          //색상
    public var series: [String]?          //시리즈
    public var embedCellulars: [String]?  //셀룰러여부
    
    //23.09.12 신우진 Kind 초기화시 Decode 생략을 위한 init함수 추가
    init(id: String = UUID().uuidString, itemType: String, storages: [String]? = nil, colors: [String]? = nil, series: [String]? = nil, embedCellulars: [String]? = nil) {
        self.id = id
        self.itemType = itemType
        self.storages = storages
        self.colors = colors
        self.series = series
        self.embedCellulars = embedCellulars
    }
    
}


/// 파베 연동
class SearchViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    @Published var productArray: [ItemInfo] = []
    @Published var searchingState: SearchingState = .none
    @Published var searchText: String = ""
    
    /// ipadData
    @Published var ipadData: Kind?
    
    /// iphoneData
    @Published var iphoneData: Kind?
    
    @Published var searchResult: [ItemInfo] = []
    @Published var searchWord: [String] = []
    
    /// 검색 완료시 타는 함수
    func updateResults() {
        self.searchWord.append(self.searchText)
    }
    
    /// 검색 취소 시 타는 함수
    func clearResults() {
        self.searchResult.removeAll()
        self.searchWord.removeAll()
    }
    
    /// 검색 결과값의 첫번째를 가져오는 함수
    func getFirstElement() -> ItemInfo? {
        if searchResult.isEmpty {
            return nil
        }
        return self.searchResult[0]
    }
    
    /// IPAD 문서 데이터 가져오기
    func ipadFetch() {
        let docRef: DocumentReference = db.collection("Kind").document("IPAD")
        
        docRef.getDocument(as: Kind.self) { result in
            switch result {
            case .success(let success):
                print("iPad Fetch 성공 : \(success)")
                self.ipadData = success
            
            case .failure(let error):
                print("iPad Fetch중 에러 : \(error.localizedDescription)")
                
            }
        }
    }
    
    /// IPHONE 문서 데이터 가져오기
    func iphoneFetch() {
        let docRef: DocumentReference = db.collection("Kind").document("IPHONE")
        
        docRef.getDocument(as: Kind.self) { result in
            switch result {
            case .success(let success):
                print("iPhone Fetch 성공 : \(success)")
                self.iphoneData = success
                
            case .failure(let error):
                print("iPhone Fetch중 에러 : \(error.localizedDescription)")
                
            }
        }
    }
    
    
    // 전체 데이터 패치해오기
    func fetchProduct() {
        db.collection("ItemInfo").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("Fetching 에러 발생   \(String(describing: error))")
                return
            }
            
            self.productArray = documents.compactMap{ doc -> ItemInfo? in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: doc.data())
                    let productArray = try JSONDecoder().decode(ItemInfo.self, from: jsonData)
                    return productArray
                } catch let error {
                    print("JSON Parsing Error \(error)")
                    return nil
                }
            }
        }
    }
    
    /// 전체 상품에서 검색 하는 함수
    func filterTest() {
            searchResult = productArray.filter { itemInfo in
                return itemInfo.productName.localizedStandardContains(searchText)
            }
        }
    
    

}
