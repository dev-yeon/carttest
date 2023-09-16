//
//  CartView.swift
//  test01
//
//  Created by yeon on 2023/09/06.

import SwiftUI
import AppleStoreCore
import FirebaseAuth

//MARK: cartView
struct CartView: View {
    @EnvironmentObject var cartItemStore: CartItemStore
    
    @State private var isLoggedIn: Bool = false // 현재 로그인 상태
    @State private var cartItemsCount: Int = 0 // 장바구니 항목 수
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationStack {
            Group {
                if isLoading {
                    ProgressView()
                } else {
                    if cartItemsCount == 0 {
                        EmptyCartView()
                    } else {
                        CartItemFormView()
                    }
//                    // 로그인 상태 확인
//                    if isLoggedIn {
//                        // 장바구니 상태 확인
//                        if cartItemsCount == 0 {
//                            EmptyCartView()
//                        } else {
//                            CartItemFormView()
//                        }
//                    } else {
//                        //GuestView(isLogin: $isLoggedIn)
//                    }
                }
            }
            .onAppear{
                checkLoginStatus()
                startLoading()
            }
        }
    }
    
    // 로그인 상태와 장바구니 상태를 확인하는 메소드
    func checkLoginStatus() {
        // 예: Firebase 인증을 사용하는 경우
        
        if let _ = Auth.auth().currentUser {
            isLoggedIn = true
            // 장바구니 상태도 확인
            checkCartStatus()
        } else {
            isLoggedIn = false
        }
    }
    
    func checkCartStatus() {
        cartItemStore.fetchCartItemsByUid2(uid: Auth.auth().currentUser?.uid ?? " ")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // 2초 후에 실행될 코드
            print("Delayed print!")
            cartItemsCount = cartItemStore.cartItems.count
        }
    }
    
    func startLoading() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isLoading = false
        }
    }
}

//MARK: cartView_Previews
struct cartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CartView()
                .environmentObject(CartItemStore())
        }
    }
}
