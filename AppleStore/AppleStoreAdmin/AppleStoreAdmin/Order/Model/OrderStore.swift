//
//  OrderStore.swift
//  AppleStoreAdmin
//
//  Created by 김유진 on 2023/09/05.
//

import Foundation
import FirebaseFirestore
import AppleStoreCore

class OrderStore: ObservableObject {
    @Published var orders: [Order] = []
    
    let dbRef = Firestore.firestore().collection("Order")
    let service = Service()
    
    func fetchAll() {
        self.orders.removeAll()
        
        service.fetchAll(collection: .order) { results in
            self.orders = results
        }
    }
    
    func fetchState(state: String) {
        self.orders.removeAll()
        
        service.fetchAll(collection: .order, whereFields: ["state"], whereTypes: [ServiceType.Where.equal], whereDatas: [state]) { results in
            self.orders = results
        }
    }
    
    func editOrder(order: Order, orderStatus: OrderStatus) {
        var newOrder: Order = order
        newOrder.state = orderStatus.rawValue

        guard let orderData = try? Firestore.Encoder().encode(newOrder) else { return }

        dbRef.document(order.id).setData(orderData)
        fetchAll()
    }
    
    func getOrder(id: String)->Order? {
        for (idx, order) in orders.enumerated(){
            if order.id == id {
                return orders[idx]
            }
        }
        return nil
    }
    
    func submitTrackingNumber(order: Order, deliveryServiceCompany: deliveryServiceCompanies, trackingNum: String){
        var newOrder: Order = order
        newOrder.deliveryServiceCompany = deliveryServiceCompany.rawValue
        newOrder.trackingNumber = trackingNum

        guard let orderData = try? Firestore.Encoder().encode(newOrder) else { return }

        dbRef.document(order.id).setData(orderData)
        fetchAll()
    }
}
