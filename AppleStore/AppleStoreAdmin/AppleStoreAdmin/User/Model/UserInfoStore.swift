//
//  UserInfoStore.swift
//  AppleStoreAdmin
//
//  Created by 송성욱 on 2023/09/07.
//

import Foundation
import FirebaseFirestore
import AppleStoreCore


final class UserInfoStore: ObservableObject {
    let service = Service()
    
    @Published var users = [User]()
    @Published var user: User = .init(uid: "", username: "", email: "")

    
    init() { }
    
    ///유저정보 fetch
    func fetchUserInfos() {
        service.fetchAll(collection: .user) { results in
            self.users = results
        }

    }

    func getUserInfo(id: String)->User? {
        for (idx, user) in users.enumerated(){
            if user.uid == id {
                return users[idx]
            }
        }
        return nil

    }
    
}

