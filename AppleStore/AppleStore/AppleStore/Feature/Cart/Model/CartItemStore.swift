//
//  CartItemStore.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/12.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import AppleStoreCore

final class CartItemStore: ObservableObject {
    @Published var cartItems: [AppleStoreCore.CartItem] = []
    
    init() {
        //TODO: 테스트용
//        fetchCartItemsByUid(uid: "L0eu6L8nNIM6D7Un4i8a70pSlq43")
    }
    
    func calcTotalPrice() -> Int {
        var totalPrice: Int = 0
        
        for cartItem in cartItems {
            totalPrice += (cartItem.price * cartItem.amount)
        }
        
        return totalPrice
    }
    
    func fetchCartItemsByUid(uid: String) async throws {
        let cartItemsRef = Firestore.firestore().collection("CartItems")
            .whereField("uid", isEqualTo: uid)
        let querySnapShot = try await cartItemsRef.getDocuments()
        
        try querySnapShot.documents.forEach { queryDocumentSnapshot in
            let tempCartItem = try queryDocumentSnapshot.data(as: CartItem.self)
            self.cartItems.append(tempCartItem)
        }
    }
    
    
    // async await 없이 해당 유저의 전체 cartItem 가져옴
    func fetchCartItemsByUid2(uid: String) {
        let cartItemsRef = Firestore.firestore().collection("CartItems")
            .whereField("uid", isEqualTo: uid)
        cartItemsRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting cartItems: \(error)")
            }
            
            self.cartItems.removeAll()
            
            guard let documents = querySnapshot?.documents else {
                print("No feeds querySnapshot.documents")
                return
            }
            
            var tempCartItems: [AppleStoreCore.CartItem] = []
            
            for document in documents {
                do {
                    let cartItem = try document.data(as: AppleStoreCore.CartItem.self)
                    tempCartItems.append(cartItem)
                } catch let error {
                    print("error document.data(as: Payment.self) : \(error)")
                }
            }
            
            DispatchQueue.main.async {
                self.cartItems = tempCartItems
            }
        }
    }
    
    // 11형 iPad Pro Wi-Fi 1TB - 실버
    // iPhone 14 Pro 1TB 딥 퍼플
    func makeCartItemName(item: Item) -> String {
        var cartItemName: String = ""
        
        //TODO: inch 데이터 숫자만인지 한글 형이 포함되는지 여부 문의하기
//        if let inch = item.inchModel {
//            cartItemName += "\(inch)형 "
//        }
        
        cartItemName += "\(item.productName)"
        
        if let cellular = item.embedCellular {
            cartItemName += " \(cellular)"
        }
        
        cartItemName += " \(item.storage) "
        cartItemName += "\(item.productColor)"
        
        return cartItemName
    }
    
    // MARK: 상세페이지에서 장바구니담기 버튼 클릭 시 호출될 함수
    func addOneItemToCart(item: Item) {
        
        let cartItemName: String = makeCartItemName(item: item)
        
        let cartItem: AppleStoreCore.CartItem = AppleStoreCore.CartItem(id: UUID().uuidString, uid: UserService.shared.currentUser?.uid ?? " ", name: cartItemName, price: item.price, amount: 1, isChecked: false, imageURL: URL(string: item.mainImageString)!)
        
        let cartItemsRef = Firestore.firestore().collection("CartItems")
            .whereField("uid", isEqualTo: UserService.shared.currentUser?.uid ?? " ")
            .whereField("name", isEqualTo: cartItem.name)
        cartItemsRef.getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting cartItems: \(error)")
            }
            
            // 없으면 카트 아이템 추가
            guard let documents = querySnapshot?.documents else {
                print("No cartItem querySnapshot.documents")
                return
            }
            
            if documents.count < 1 {
                self.addCartItem(cartItem: cartItem)
            }
            
            // 있으면 수량 1 증가
            for document in documents {
                do {
                    var cartItem = try document.data(as: AppleStoreCore.CartItem.self)
                    cartItem.amount += 1
                    
                    self.updateAmountInCartItem(cartItem: cartItem)
                } catch let error {
                    print("error data(as: AppleStoreCore.CartItem.self) : \(error)")
                }
            }
        }
    }
    
    // 카트 아이템 하나 추가
    private func addCartItem(cartItem: AppleStoreCore.CartItem) {
        do {
            try Firestore.firestore().collection("CartItems").document(cartItem.id).setData(from: cartItem)
            self.cartItems.append(cartItem)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
    
    // 해당 카트 아이템의 수량 변경
    func updateAmountInCartItem(cartItem: AppleStoreCore.CartItem) {
        Firestore.firestore().collection("CartItems").document(cartItem.id).updateData(["amount" : cartItem.amount])
        if let idx = cartItems.firstIndex(where: { $0.id == cartItem.id}) {
            cartItems[idx].amount = cartItem.amount
        }
    }
    
    // 해당 유저의 카트 아이템 전체 삭제 (결제 완료시 사용)
    func deleteAllCartItemByUid(uid: String) {
//        fetchCartItemsByUid(uid: uid)
        // TODO: fetch 이 후 돌아가는 것 테스트하기
        for cartItem in cartItems {
            deleteCartItem(cartItem: cartItem)
        }
    }
    
    // 카트 아이템 한 개 삭제
    func deleteCartItem(cartItem: AppleStoreCore.CartItem) {
        let cartItemRef = Firestore.firestore().collection("CartItems")
        cartItemRef.document(cartItem.id).delete() { error in
            if let err = error {
                print("Error removing document: \(err)")
            } else {
                if let idx = self.cartItems.firstIndex(where: { $0.id == cartItem.id}) {
                    self.cartItems.remove(at: idx)
                }
                print("Document successfully removed!")
            }
        }
    }
}
