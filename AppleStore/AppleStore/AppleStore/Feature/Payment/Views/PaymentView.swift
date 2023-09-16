//
//  PaymentView.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/07.
//

import SwiftUI
import AppleStoreCore

struct PaymentView: View {
    
    @Binding var isShowingPaymetSheet: Bool
    let cartItems: [CartItem]
    
    @State var isShowingBankTransferSheet: Bool = false
    @State var isShowingZipCodeSheet: Bool = false
    
    @State private var isShowingCancelAlert = false
    @State private var isShowingOrderAlert = false
    
    @State private var isDisablePaymetButton = true
    
    var getTotalPrice: Int {
        // TODO: 장바구니에서 넘어온 데이터로 계산기능 추가
        var totalPrice: Int = 0
        for cartItem in cartItems {
            totalPrice += cartItem.price * cartItem.amount
        }
        return totalPrice
    }
    
    var body: some View {
        NavigationStack {
            Form {
                ForEach(cartItems) { cartItem in
                    Section {
                        ProductsToBePaidView(cartItem: cartItem)
                    }
                }
                
                Section {
                    ShowShippingAddressView()
                    
                    PaymentTotalPriceView(totalPrice: getTotalPrice)
                    
                    PaymentApplePolicyView( isDisablePaymetButton: $isDisablePaymetButton)
                }
                PaymentTermsAndConditionsView()
            }
        }
        .navigationTitle("결제")
        .navigationBarTitleDisplayMode(.inline)
        // TODO: 커스텀 alert 고려, 버튼 위아래로 배치하고 싶다.
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    isShowingCancelAlert = true
                } label: {
                    Text("취소")
                }
                .alert(isPresented: $isShowingCancelAlert) {
                    let firstButton = Alert.Button.destructive(Text("결제 취소")) {
                        isShowingPaymetSheet = false
                    }
                    let secondButton = Alert.Button.default(Text("결제 계속")) {
                    }
                    return Alert(title: Text(""),
                                 message: Text("주문이 완료되지 않은 상태에서 결제를 취소하시겠습니까?"),
                                 primaryButton: firstButton, secondaryButton: secondButton)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isShowingOrderAlert = true
                    
                } label: {
                    Text("주문")
                }
                .buttonStyle(.borderedProminent)
                .disabled(isDisablePaymetButton)
                .alert(isPresented: $isShowingOrderAlert) {
                    let firstButton = Alert.Button.destructive(Text("결제 취소")) {
                        
                    }
                    let secondButton = Alert.Button.default(Text("결제 완료")) {
                        isShowingBankTransferSheet = true
                    }
                    return Alert(title: Text("결제가 완료됩니다."),
                                 message: Text("이 후 무통장입금 안내 페이지로 이동합니다."),
                                 primaryButton: firstButton, secondaryButton: secondButton)
                }
            }
        }
        .sheet(isPresented: $isShowingBankTransferSheet) {
            NavigationStack {
                BankTransferView(totalPrice: getTotalPrice, isShowingBankTransferSheet: $isShowingBankTransferSheet, isShowingPaymetSheet: $isShowingPaymetSheet)
            }
        }
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PaymentView(isShowingPaymetSheet: .constant(true), cartItems: [])
        }
    }
}
