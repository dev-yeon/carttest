//
//  PaymentStore.swift
//  AppleStoreAdmin
//
//  Created by 김유진 on 2023/09/12.
//

import Foundation
import Firebase
import AppleStoreCore

class PaymentStore: ObservableObject {
    
    @Published var payment: Payment?
    
    private let dbRef = Firestore.firestore().collection("Payment")
    private let service = Service()
    
    func fetchAPayment(paymentId: String) {
        service.fetchOneData(collection: .payment, documentID: paymentId) { result in
            self.payment = result
        }
    }
    
    func setPaymentIsPayed(payment: Payment?) {
        if let payment = payment {
            var tempPayment = payment
            tempPayment.isPayed = true
            
            guard let paymentData = try? Firestore.Encoder().encode(tempPayment) else { return }
            
            dbRef.document(payment.id).setData(paymentData)
            fetchAPayment(paymentId: payment.id)
        }
    }
}
