//
//  BankTransferView.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/07.
//

import SwiftUI

struct BankTransferView: View {
    @EnvironmentObject var cartItemStore: CartItemStore
    @EnvironmentObject var orderStore: OrderStore
    
    // defalt 값
    let totalPrice: Int
    @State private var payment: Payment = Payment(uid: UserService.shared.currentUser?.uid ?? "FU7FdxLNraYF0uO1Q6SQP9FtgA13", isPayed: false, bankName: "멋사은행", bankAccountNumber: "xxxx-xx-xxxxxxx", totalPrice: 599000)
    @State private var isCopied: Bool = false
    
    @Binding var isShowingBankTransferSheet: Bool
    @Binding var isShowingPaymetSheet: Bool
    @State private var isShowingAlert = false

    var body: some View {
        VStack {
            Spacer()
            // TODO: 은행 선택화면 추가 예정
            //      sheet or 화면 밑 고민 중
            SelectBankView(payment: $payment)
            
            Text("₩ \(payment.totalPrice)")
                .font(.largeTitle)
                .padding(.bottom)
            
            BankAccountNumberView(bankAccountNumber: payment.bankAccountNumber, isCopied: $isCopied)
            
            Spacer()
            
            if isCopied {
                Text("계좌번호가 복사되었습니다")
                    .padding()
                    .font(.title3)
                    .foregroundColor(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                    }
                    .onAppear() {
                        // 나타나고 1초 후 스르륵 사라짐
                        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                            withAnimation(.easeIn(duration:1.0)) {
                                // 클립보드에 복사
                                clipboardData(payment.bankName +  payment.bankAccountNumber)
                                isCopied = false
                            }
                        }
                    }
            }
        }
        .padding()
        .navigationTitle("무통장 입금")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            payment = Payment(uid: UserService.shared.currentUser?.uid ?? "FU7FdxLNraYF0uO1Q6SQP9FtgA13", isPayed: false, bankName: payment.bankName, bankAccountNumber: payment.bankAccountNumber, totalPrice: totalPrice)
            PaymentStore().addPayment(payment: payment)
        }
        .interactiveDismissDisabled(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                    let user = UserService.shared.currentUser ?? User(uid: UUID().uuidString, userName: "없는유저", email: "eeeemtpy@gmail.com")
                    let order = Order(uid: payment.uid, productName: cartItemStore.cartItems[0].name, price: payment.totalPrice, imageURLString: cartItemStore.cartItems[0].imageURL.absoluteString, paymentId: payment.id,prostal: user.postal, headAddress: user.headAddress, detailAddress: user.detailAddress, nation: user.nation, phone: user.phone, createdAt: Date().timeIntervalSince1970)
                    orderStore.addOrder(order)
                    

                    cartItemStore.deleteAllCartItemByUid(uid: UserService.shared.currentUser?.uid ?? "FU7FdxLNraYF0uO1Q6SQP9FtgA13")
                    isShowingPaymetSheet = false
                    isShowingBankTransferSheet = false
                } label: {
                    Text("닫기")
                }
                .buttonStyle(.borderedProminent)
                
            }
        }
    }
    
    private func clipboardData(_ message: String) {
        UIPasteboard.general.string = "\(payment.bankName) \(payment.bankAccountNumber)"
    }
}

struct BankTransferView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BankTransferView(totalPrice: 599000,  isShowingBankTransferSheet: .constant(true), isShowingPaymetSheet: .constant(true))
        }
    }
}
