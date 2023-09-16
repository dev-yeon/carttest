//
//  UserSerive.swift
//  AppleStore
//
//  Created by 윤해수 on 2023/09/06.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class UserService: ObservableObject {
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    init() {
        Task { try await fetchUser() }
    }
    
    /// 로그인한 유저 정보
    @MainActor
    func fetchUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("Users").document(uid).getDocument()
        
        let user = try snapshot.data(as: User.self)
        
        self.currentUser = user
        
        print("Debug: User is \(self.currentUser)")
    }
    
    static func fetchOrders() async throws -> [Order] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
        let snapshot = try await Firestore.firestore().collection("Order").whereField("uid", isEqualTo: currentUid).order(by: "createdAt", descending: true).getDocuments()
        let orders = snapshot.documents.compactMap({try? $0.data(as: Order.self) })
        print(orders)
        return orders
    }
    func reset() {
        self.currentUser = nil
    }
}
