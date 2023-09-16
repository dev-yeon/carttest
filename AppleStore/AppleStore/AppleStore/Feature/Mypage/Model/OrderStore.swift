//
//  OrderStore.swift
//  AppleStore
//
//  Created by dayexx on 2023/09/05.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class OrderStore: ObservableObject {
    @Published var orders: [Order] = []
    
    var loginUserID: String = UserService.shared.currentUser?.uid ?? "SSF5uC4OBndmE8GGu58kMlH8YUn1"
    let dbRef = Firestore.firestore().collection("Order")
    
    init() {
        fetchOrder_v()
        
    }
    
    
    func fetchOrder_v() {
        Task{
            orders = try await UserService.fetchOrders()
            print("orders : \(orders)")
        }
    }
    
    func fetchOrders() {
        if let loginUserID = UserService.shared.currentUser?.uid {
            dbRef.whereField("uid", isEqualTo: loginUserID).order(by: "createdAt", descending: true).getDocuments{(snapshot, error) in
                self.orders.removeAll()
                if let snapshot {
                    var tempOrder: [Order] = []
                    print(snapshot.documents)
                    
                    for document in snapshot.documents {
                        let id: String = document.documentID
                        let docData: [String : Any] = document.data()
                        
                        let uid: String = docData["uid"] as? String ?? ""
                        let productName: String = docData["productName"] as? String ?? ""
                        let price: Int = docData["price"] as? Int ?? 0
                        let state: String = docData["state"] as? String ?? "입금 대기"
                        let imageURLString : String  = docData["imageURLString"] as? String ?? ""
                        let paymentId: String = docData["paymentId"] as? String ?? ""
                        let createdAt: Double = docData["createdAt"] as? Double ?? 0
                        
                        let order = Order(id: id, uid: uid, productName: productName, price: price, state: state, imageURLString: imageURLString, paymentId: paymentId, createdAt: createdAt)
                        
                        tempOrder.append(order)
                    }
                    
                    // DispatchQueue
                    DispatchQueue.main.async {
                        self.orders = tempOrder
                    }
                    
                }
            }
        }
    }
    /*
     addOrder 받아올때 예시
     
     let newOrder = Order(
     id: UUID().uuidString
     productName: productName
     price: price
     imageURLString: imageURLString
     paymentId: paymentId
     )
     feedStore.addOrder(newOrder)
     
     */
    
    func addOrder(_ order: Order){
        guard let orderData = try? Firestore.Encoder().encode(order) else { return }
        
        dbRef.document(order.id).setData(orderData)
        fetchOrders()
    }
    
    func removeOrder(_ order: Order) {
        dbRef.document(order.id).delete()
        fetchOrders()
    }
    
}
