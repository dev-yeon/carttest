//
//  BookMark.swift
//  AppleStore
//
//  Created by dayexx on 2023/09/05.
//

import Foundation

struct BookMark: Identifiable {
    var id: UUID = UUID()
    var uid: String
    var productId: String //아니면 productId만으로 조회
    var productName : String
    var price: Int
    var imageURLString: String
    var imageURL: URL {
        get {
            return URL(string: imageURLString)!
        }
    }
}
