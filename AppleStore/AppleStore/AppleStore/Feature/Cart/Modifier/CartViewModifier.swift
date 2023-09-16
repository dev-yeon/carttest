////
////  CartViewModifier.swift
////  AppleStore
////
////  Created by yeon on 2023/09/07.
////
//
//
//import SwiftUI
//struct CartItemInitializer: ViewModifier {
//    @Binding var cartItems: [CartItem]
//    
//    func body(content: Content) -> some View {
//        if cartItems.isEmpty { // 만약 cartItems가 비어 있다면?
//            let item1 = CartItem(id: UUID(), name: "iPad Pro", price: 2000000, amount: 1, isChecked: false)
//            let item2 = CartItem(id: UUID(), name: "iPhone14", price: 1000000, amount: 1, isChecked: false)
//            
//            DispatchQueue.main.async {
//                cartItems = [item1, item2]
//            }
//        }
//        
//        return content // 이 부분이 모든 경로에서 반환되도록 외부로 이동
//    }
//}
//
//extension View {
//    func initializeCartItems(cartItems: Binding<[CartItem]>) -> some View {
//        self.modifier(CartItemInitializer(cartItems: cartItems))
//    }
//}
