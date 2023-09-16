////
////  CartViewModel.swift
////  AppleStore
////
////  Created by yeon on 2023/09/07.
////
//
//import Foundation
//
//
////MARK: CartItem
////struct CartItem: Identifiable {
////    let id: UUID
////    let name: String
////    let price: Int
////    var amount: Int
////    var isChecked: Bool
////}
//
////MARK: CartViewModel
//
//class CartViewModel: ObservableObject {
//    
//    @Published var isEditing: Bool = false
//    
//    @Published var cartItems: [CartItem] = []
//    @Published var isAllItemsChecked: Bool = false {
//        didSet {
//            cartItems = cartItems.map {
//                var mutableItem = $0
//                mutableItem.isChecked = isAllItemsChecked
//                return mutableItem
//            }
//        }
//    }
//    
//    var totalPrice: Int {
//        return cartItems.reduce(0) { $0 + ($1.isChecked ? $1.price * $1.amount : 0) }
//    }
//    //MARK: 초기 데이터 2개
//    
//    init() {
//        let item1 = CartItem(id: UUID(), name: "iPad Pro", price: 2000000, amount: 1, isChecked: false)
//        let item2 = CartItem(id: UUID(), name: "iPhone14", price: 1000000, amount: 1, isChecked: false)
//        cartItems = [item1, item2]
//    }
//  
//
//    func updateAmount(id: UUID, amount: Int) {
//        if let index = cartItems.firstIndex(where: { $0.id == id }) {
//            
//            if amount <= 0 { // 수량이 0이하인 경우
//                cartItems.remove(at: index)
//            } else {
//                var item = cartItems[index]
//                item.amount = amount
//                cartItems[index] = item
//            }
//        }
//    }
//    func updateCheckedStatus(id: UUID, isChecked: Bool) {
//        if let index = cartItems.firstIndex(where: { $0.id == id }) {
//            var item = cartItems[index]
//            item.isChecked = isChecked
//            cartItems[index] = item
//        }
//    }
//    //CartViewModel에 선택된 항목이 있는지 확인하는 메서드
//    func hasSelectedItems() -> Bool {
//        return cartItems.contains { $0.isChecked }
//    }
//    func clearSelectedCart() {
//        cartItems.removeAll { $0.isChecked }
//    }
//    
//    func deleteItems(at offsets: IndexSet) {
//        cartItems.remove(atOffsets: offsets)
//    }
//    //CartView 편집상태에서 삭제하는거 
//    func deleteSelectedItems() {
//        cartItems.removeAll { $0.isChecked }
//    }
//    
//    func deleteEditSelectedItems() {
//        cartItems = cartItems.filter { !$0.isChecked }
//    }
//
//    func deleteAllItems() {
//        cartItems.removeAll()
//    }
//    
//    func moveItems(from source: IndexSet, to destination: Int) {
//        cartItems.move(fromOffsets: source, toOffset: destination)
//    }
//    
//    func toggleEditMode() {
//        isEditing.toggle()
//    }
//    // 타입변환으로 카트아이템을 위시아이템으로 만들어주었다 .
//    func convertToWishListItem(cartItem: CartItem) -> WishListItem {
//        return WishListItem(id: cartItem.id, name: cartItem.name, price: cartItem.price, isAdded: false)
//    }
//    
//}
//
//
