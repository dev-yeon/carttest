//
//  CategoryModel.swift
//  AppleStoreAdmin
//
//  Created by woojin Shin on 2023/09/07.
//

import SwiftUI
import FirebaseFirestoreSwift
import AppleStoreCore

//MARK: - Enum
enum Types: String {
    case storage = "용량"
    case color = "색상"
    case series = "Series"
    case embedCellular = "셀룰러여부"
//    case ipadInch = "인치"
//    case item = "품목"

}

enum ItemType: String, CaseIterable, Identifiable {
    case iphone = "IPHONE"
    case ipad = "IPAD"
//    case watch = "애플워치"
    
    var id: ItemType { self }

}


//MARK: - Store
//struct Kind: Identifiable, Codable {
//    @DocumentID var id: String?
//
////    let itemType: String           //아이폰, 아이패드
////    var storages: [String]        //용량
////    var colors: [String]          //색상
////    var series: [String]          //시리즈
////    var embedCellulars: [String]?  //셀룰러여부
//
//
//    let itemType: String           //아이폰, 아이패드
//    var storages: [String]?              //용량
//    var colors: [String]?                   //색상
//    var series: [String]?                   //시리즈
//    var embedCellulars: [String]?            //셀룰러여부
//
//}


extension Kind {
    ///값가져오는 메서드
    func dynamicGetData( type: Types ) -> String {
        var compareData =  ""
        
        switch type {
        case .color:
            compareData = self.colors?.first ?? ""
        case .embedCellular:
            compareData = self.embedCellulars?.first ?? ""
        case .series:
            compareData = self.series?.first ?? ""
        case .storage:
            compareData = self.storages?.first ?? ""
//        case .ipadInch:
//            compareData = self.ipadInchs?.first ?? ""
        }
        
        return compareData
    }
    
    ///배열로 가져오기
    func dynamicGetArray( type: Types ) -> [String] {
        var getDatas = [String]()
        
        switch type {
        case .color:
            getDatas = self.colors ?? []
        case .embedCellular:
            getDatas = self.embedCellulars ?? []
        case .series:
            getDatas = self.series ?? []
        case .storage:
            getDatas = self.storages ?? []
//        case .ipadInch:
//            getDatas = self.ipadInchs ?? []
        }
        
        return getDatas
    }
    
    ///비교구문
    func dynamicCompareData( type: Types, compareData: String ) -> Bool {
        var result = false
        
        switch type {
        case .color:
            result = self.colors?.contains { $0 == compareData } ?? false
        case .embedCellular:
            result = self.embedCellulars?.contains { $0 == compareData } ?? false
        case .series:
            result = self.series?.contains { $0 == compareData } ?? false
        case .storage:
            result = self.storages?.contains { $0 == compareData } ?? false
//        case .ipadInch:
//            result = self.ipadInchs?.contains { $0 == compareData } ?? false
        }
        
        return result
    }
    
    ///추가 메서드
    mutating func dynamicSetData( type: Types, setData: String ) {

        switch type {
        case .color:
            if self.colors == nil {
                self.colors = [] // 배열이 nil이면 빈 배열로 초기화
            }
            self.colors?.append(setData)
            
        case .embedCellular:
            if self.embedCellulars == nil {
                self.embedCellulars = [] // 배열이 nil이면 빈 배열로 초기화
            }
            self.embedCellulars?.append(setData)
        case .series:
            if self.series == nil {
                self.series = [] // 배열이 nil이면 빈 배열로 초기화
            }
            
            self.series?.append(setData)
            
        case .storage:
            if self.storages == nil {
                self.storages = [] // 배열이 nil이면 빈 배열로 초기화
            }
            self.storages?.append(setData)
            
//        case .ipadInch:
//            if self.ipadInchs == nil {
//                self.ipadInchs = [] // 배열이 nil이면 빈 배열로 초기화
//            }
//            self.ipadInchs?.append(setData)
        }
        
        return
    }
    
    
    ///추가 메서드
    mutating func dynamicSetData( type: Types, setData: [String] ) {

        switch type {
        case .color:
            if self.colors == nil {
                self.colors = [] // 배열이 nil이면 빈 배열로 초기화
            }
            self.colors? = setData
        case .embedCellular:
            if self.embedCellulars == nil {
                self.embedCellulars = [] // 배열이 nil이면 빈 배열로 초기화
            }
            self.embedCellulars? = setData
        case .series:
            if self.series == nil {
                self.series = [] // 배열이 nil이면 빈 배열로 초기화
            }
            
            self.series? = setData
            
        case .storage:
            if self.storages == nil {
                self.storages = [] // 배열이 nil이면 빈 배열로 초기화
            }
            self.storages? = setData
            
//        case .ipadInch:
//            if self.ipadInchs == nil {
//                self.ipadInchs = [] // 배열이 nil이면 빈 배열로 초기화
//            }
//            self.ipadInchs? = setData
        }
        
        return
    }
    
    
    mutating func dynamicRemove( type: Types, indexSet: IndexSet ) {

        for index in indexSet {
            switch type {
            case .color:
                self.colors?.remove(at: index)
            case .embedCellular:
                self.embedCellulars?.remove(at: index)
            case .series:
                self.series?.remove(at: index)
            case .storage:
                self.storages?.remove(at: index)
//            case .ipadInch:
//                self.ipadInchs?.remove(at: index)
            }
        }
        
        return
        
    }
    
}


//MARK: - Model
final class CategoryModel: ObservableObject {
    let service = Service()
    
    var type: String = ""
    
    @Published var kind = Kind(itemType: "")
    
    init(){ }
    
    
    func addUpData( data: Kind, type: Types ) {
        var newData = Kind(itemType: "")
        var compareData: String = ""
        
        //처음 추가할때는 한개만 들어간다.
        compareData = data.dynamicGetData(type: type)
        
        guard compareData != "" else {
            print("값이 제대로 입력되지 않았습니다.")
            return
        }
        
        
        service.fetchOneData(collection: .kind, documentID: data.itemType) { [self] result in
            newData = result
            
            if !newData.itemType.isEmpty {
                let isContains = newData.dynamicCompareData(type: type, compareData: compareData)

                if !isContains {
                    newData.dynamicSetData(type: type, setData: compareData)
                    
                    service.update(collection: .kind, documentID: newData.itemType, data: newData) { _ in
                        //추후에 작업하자..
                    }
                    
                    return

                }
            } else {
                service.add(collection: .kind, docID: data.itemType, data: data) { _ in
                    //추후에 작업하자..
                }
                return
            }
            
        }
        
    }
    
    
    func fetchData(itemType: ItemType) {
        service.fetchOneData(collection: .kind, documentID: itemType.rawValue) { result in
            self.kind = result
        }
    }
    
    
    func removeData(itemType: ItemType, type: Types, indexSet: IndexSet) {
        var kindDatas = self.kind.dynamicGetArray(type: type)
        
        for index in indexSet {
            kindDatas.remove(at: index)
        }
        
        
//        print("kindData: \(self.kind)  \(kindDatas)")
        
        self.kind.dynamicSetData(type: type, setData: kindDatas)
        
        service.update(collection: .kind, documentID: itemType.rawValue, data: self.kind) { _ in
            
        }
        
    }
    
}



