//
//  ItemViewModel.swift
//  AppleStoreAdmin
//
//  Created by woojin Shin on 2023/09/05.
//

import SwiftUI
import AppleStoreCore


//제품 상태
enum Status: Int, CaseIterable, Identifiable {
    case noPro = 0
    case pause = 1
    case finished = 2
    case new = 3
    
    var id: Status { self }
    
    var displayName: String {
        switch self {
        case .noPro: return "문제없음"
        case .pause: return "일시 품절"
        case .finished: return "판매 삭제"
        case .new: return "신제품 (new)"
        }
    }
}


//변경후
//struct ItemInfo: Identifiable, Codable {
//    let id: String  // 시리즈별 아이템의 고유 식별자 (ItemID)
//    let itemType: String
//    var seriesName: String      //아이폰 시리즈 이름 예: iPhone 14  / iPhone 14 Pro [프로라인업]  //  ->> 등록할때 정해진 값을 선택하게 할 것임. (직접치지 않음) 서버에서 불러옴
//    var productName: String              //아이폰 시리즈 내의 제품들 예: iPhone 14, iPhone 14Plus   // ->> 직접 입력
//    var description: String     //제품 부연설명
//    var price: String                   //제품들 옵션에 따른 가격들, Int로 쓸지 String으로 쓸지 체크
//    var mainImageString: String          //구매페이지에서 먼저 보이는 이미지들, 옵션 선택마다 이미지가 바뀌어서 배열로 일단 뒀음
//    var productColor: String             //시리즈에 따른 색상들   //  ->> 등록할때 정해진 값을 선택하게 할 것임. (직접치지 않음)
//    var storage: String            //저장용량들, Int로 할지 String으로 할지 체크  //  ->> 등록할때 정해진 값을 선택하게 할 것임. (직접치지 않음)
//    var status: Int          // 0 문제 없음, 1 단종됨, 일시 품절  2. 판매 삭제 3. 신제품류   //  ->> 등록할때 정해진 값을 선택하게 할 것임. (직접치지 않음)
//    var embedCellular: String = ""
//
//
//    init(id: String = UUID().uuidString, itemType: String, seriesName: String, productName: String, description: String, price: String, mainImageString: String, productColor: String, storage: String, status: Int, embedCellular: String) {
//        self.id = id
//        self.itemType = itemType
//        self.seriesName = seriesName
//        self.productName = productName
//        self.description = description
//        self.price = price
//        self.mainImageString = mainImageString
//        self.productColor = productColor
//        self.storage = storage
//        self.status = status
//        self.embedCellular = embedCellular
//    }
//
//
//}

extension ItemInfo {
    ///모든필드의 값이 들어있는지 확인
    func fieldsEmptyCheck(exceptFields: [String]) -> String {
        let mirror = Mirror(reflecting: self)
        for (label, value) in mirror.children {
            
            if let label {
                if exceptFields.isEmpty {
                    if let stringValue = value as? String, stringValue.isEmpty {
                        return label
                    }
                    
                } else {
                    //exceptField가 아닌 것만 값유무 판단
                    if !exceptFields.contains(where: {
                        return $0 == label
                    }) {
                        
                        if let stringValue = value as? String, stringValue.isEmpty {
                            return label
                        }
                        
                    }
                    
                }
            }
        }
        
        return ""
    }
}



final class ItemViewModel: ObservableObject {
    let service = Service()
  
    @Published var itemInfo: ItemInfo = .init(itemType: "", seriesName: "", productName: "", description: "", price: "", mainImageString: "", productColor: "", storage: "", status: 3, embedCellular: "")      //제품정보 Store
    @Published var itemInfos = [ItemInfo]()
    
    @Published var kind = Kind(itemType: "")    //카테고리Store
//    @Published var itemDocID = ""               //제품Store 문서번호

    
    @Published var categorys = [String : [String]]()
    
    @Published var chgViewType: ChangeViewType = .none
    
    init(){ }
    
    ///뷰변경 상태감지
    enum ChangeViewType {
        case list
        case add
        case none
    }
    
    ///서버등록 성공여부
    enum RegistStatus {
        case complete
        case emptyField
    }
    
    
    ///카테고리 데이터 가져오기
    func fetchKind( docID: String, completaion: @escaping (Kind) -> Void ) {
        guard docID != "" else { return }
        
        service.fetchOneData(collection: .kind, documentID: docID) { result in
            self.kind = result
            completaion(result)
        }
    }
    
    func fetchItemInfo( docID: String, completaion: @escaping (ItemInfo) -> Void ) {
        guard docID != "" else { return }
        
        service.fetchOneData(collection: .itemInfo, documentID: docID) { result in

            self.itemInfo = result
            completaion(result)
        }
    }
    
    func addItemInfo(docID: String, completion: @escaping (Bool) -> Void) {
        guard docID != "" else { return }
        //true는 성공 , false는 실패
        service.add(collection: .itemInfo, docID: docID, data: self.itemInfo) {
            completion($0)
        }
    }
    
    ///필드 값 체크
    func itemFieldCheck(exceptFields: [String] = []) -> (RegistStatus, String) {
        //중복체크를 할 기준이 없다..!!
        
        //모든 필드에 값이 들어갔는지 체크
        let emptyField = self.itemInfo.fieldsEmptyCheck(exceptFields: exceptFields)
        if emptyField != "" {
            return (.emptyField, emptyField )
        }
        
        return (.complete, "")
    }
    
    
    ///제품정보 삭제
    func deleteItemInfo(docID: String, completion: @escaping (Bool) -> Void) {
        guard docID != "" else { return }
        service.remove(collection: .itemInfo, documentID: docID) {
            completion($0)
        }
    }
    
    
    ///제품정보 수정
    func updateItemInfo(docID: String, completion: @escaping (Bool) -> Void ) {
        guard docID != "" else { return }
        service.update(collection: .itemInfo, documentID: docID, data: self.itemInfo) {

            completion($0)
        }
    }
    
    ///제품정보 여러개 가져오기
    func fetchItemInfoArray(where fields: [String] = [], whereData datas: [Any]? = nil) {
        self.itemInfos.removeAll()   //초기화
        
        if !fields.isEmpty {
            service.fetchAll(collection: .itemInfo, whereFields: fields, whereDatas: datas) { results in
                self.itemInfos = results
                
            }
        } else {
            service.fetchAll(collection: .itemInfo) { results in
                self.itemInfos = results
            }
        }
    }
    
    ///카테고리 배열 만들기
    func makeCategoryArray() {
        var itemInfoTemp = [ItemInfo]()
        var categorysTemp = [String : [String]]()
        let checkFields = ["productColor","storage","seriesName","price","embedCellular"] //String, Int 타입의 필드만입력

        service.fetchAll(collection: .itemInfo) { itemInfo in
            itemInfoTemp = itemInfo
            
            for item in itemInfoTemp {
                let mirror = Mirror(reflecting: item)
                
                for (label, value) in mirror.children {

                    if let label {
                        //checkFields의 속한 필드만 체크
                        if checkFields.contains(where: {
                            return $0 == label
                        }) {
                            if let stringValue = value as? String {
                                //
                                if !stringValue.isEmpty {
                                    if let categoryKey = categorysTemp[label] {
                                        if !categoryKey.contains(stringValue) {
                                            print("stringValue : \(stringValue)")
                                            categorysTemp[label]!.append(stringValue)
                                        }
                                    } else {
                                        categorysTemp[label] = [stringValue]
                                    }
                                }
                            } else if let intValue = value as? Int {
                                
                                let stringValue = String(intValue)
                                if !stringValue.isEmpty {
                                    if let categoryKey = categorysTemp[label] {
                                        if !categoryKey.contains(stringValue) {
                                            categorysTemp[label]!.append(stringValue)
                                        }
                                    } else {
                                        categorysTemp[label] = [stringValue]
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            
//            print("카테고리배열 : \(categorysTemp)")
            self.categorys = categorysTemp
            
        }
        
    }
    
}



struct ItemRegistAddView2_Previews: PreviewProvider {
    static var previews: some View {
        ItemRegistEditView()
        //        ItemRegistListView()
        
    }
}
