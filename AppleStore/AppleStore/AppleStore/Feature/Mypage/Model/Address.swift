//
//  Address.swift
//  AppleStore
//
//  Created by dayexx on 2023/09/06.
//

import Foundation

struct Address: Identifiable {
    var id: UUID = UUID()
    var userName: String
    var prostal: String
    var headAddress: String
    var detailAddress: String?
    var nation: String
    var phone: String
}
