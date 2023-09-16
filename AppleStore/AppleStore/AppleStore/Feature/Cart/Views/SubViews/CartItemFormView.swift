//
//  CartItemFormView.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/13.
//

import SwiftUI
import AppleStoreCore

struct CartItemFormView: View {
    @EnvironmentObject var cartItemStore: CartItemStore
    @State var isShowingPaymetSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            if cartItemStore.cartItems.count > 0 {
                Form {
                    ForEach(cartItemStore.cartItems) { cartItem in
                        Section {
                            ProductsToBePaidView(cartItem: cartItem)
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let tempCartItem = cartItemStore.cartItems[index]
                            cartItemStore.deleteCartItem(cartItem: tempCartItem)
                        }
                    }
                    
                    CartTotalPriceView(totalPrice: cartItemStore.calcTotalPrice())
                }
                
                .navigationTitle("장바구니")
                .refreshable {
                    cartItemStore.fetchCartItemsByUid2(uid: UserService.shared.currentUser?.uid ?? "")
                }
                .toolbar {
                    ToolbarItem {
                        
                        Button {
                            isShowingPaymetSheet = true
                        } label: {
                            Text("결제")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    ToolbarItem(placement: .navigationBarLeading)  {
                        EditButton()
                    }
                }
                .sheet(isPresented: $isShowingPaymetSheet) {
                    NavigationStack {
                        PaymentView(isShowingPaymetSheet: $isShowingPaymetSheet, cartItems: cartItemStore.cartItems)
                    }
                }
            } else {
                EmptyCartView()
            }
        }
    }
}

struct CartItemFormView_Previews: PreviewProvider {
    static var previews: some View {
        CartItemFormView()
    }
}
