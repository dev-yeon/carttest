//
//  PaymentStore.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/11.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

final class PaymentStore: ObservableObject {
    
    @Published private var paymentList: [Payment] = []
    
    init() {
//        payment = Payment(uid: UUID().uuidString, isPayed: false, bankName: "멋사은행", bankAccountNumber: "xxxx-xx-xxxxxxx", totalPrice: 599000)
    }
    
    func addPayment(payment: Payment) {
        do {
            try Firestore.firestore().collection("Payment").document(payment.id).setData(from: payment)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
    
    
    func fetchAllPayment() {
        let paymentRef = Firestore.firestore().collection("Payment")
        paymentRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting feeds: \(error)")
                return
            }
            self.paymentList.removeAll()
            
            guard let documents = querySnapshot?.documents else {
                print("No feeds querySnapshot.documents")
                return
            }
            
            var tempPaymentList: [Payment] = []
            
            for document in documents {
                
//                let id = document.documentID
//                let docData = document.data()
//
//                let uid = docData["uid"] as? String ?? ""
//                let isPayed = docData["isPayed"] as? Bool ?? false
//                let bankName = docData["bankName"] as? String ?? ""
//                let bankAccountNumber = docData["bankAccountNumber"] as? String ?? ""
//                let totalPrice = docData["totalPrice"] as? Int ?? 0
//                let createdAt = docData["createdAt"] as? Double ?? Date().timeIntervalSince1970
//
//                tempPaymentList.append(
//                    Payment(id: id, uid: uid, isPayed: isPayed, bankName: bankName, bankAccountNumber: bankAccountNumber, totalPrice: totalPrice, createdAt: createdAt)
//                )
                do {
                    let payment = try document.data(as: Payment.self)
                    tempPaymentList.append(payment)
                } catch let error {
                    print("error document.data(as: Payment.self) : \(error)")
                }
            }
            
            DispatchQueue.main.async {
                self.paymentList = tempPaymentList
            }
        }
    }
}
