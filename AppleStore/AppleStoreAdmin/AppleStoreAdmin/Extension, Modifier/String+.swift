//
//  String+.swift
//  AppleStoreAdmin
//
//  Created by woojin Shin on 2023/09/12.
//

import SwiftUI


extension String {
    var getNameColor: [String] {
        let components = self.split(separator: "/").map { String($0) }
        
        var returnValue = components.isEmpty ? [""] : components
        
        //무조건 2개의 값을 만들어서 런타임에러 방지 ㅋㅎ
        for index in 0..<2 {
            //값이 있으면 패스 없으면 넣어준다.
            if !returnValue.indices.contains(index) {
                returnValue.insert("", at: index)
            }
        }
        
//        print("reee \(returnValue)")
        
        return returnValue
    }
    
    
    var convertColName: String {
        switch self {
        case "seriesName":
            return "Series"
        case "price":
            return "가격"
        case "productColor":
            return "색상"
        case "storage":
            return "용량"
        case "embedCellular":
            return "모델"
        case "status":
            return "상태"
        case "mainImageString":
            return "이미지URL"
        case "productName":
            return "제품명"
        case "itemType":
            return "제품타입"
        default:
            return self
        }
    }
    
}
