//
//  SelectBankView.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/09.
//

import SwiftUI

struct SelectBankView: View {
    @Binding var payment: Payment
    
    var body: some View {
        VStack {
            Image(systemName: "apple.logo")
                .font(Font.system(size: 100))
                .padding(.bottom)
            
            Text("\(payment.bankName)")
                .font(.title)
                .padding(.bottom,1)
            Text("예금주 : 애플")
                .padding(.bottom)
        }
    }
}

struct SelectBankView_Previews: PreviewProvider {
    static var previews: some View {
        SelectBankView(payment: .constant(Payment(uid: UUID().uuidString, isPayed: false, bankName: "멋사은행", bankAccountNumber: "xxxx-xx-xxxxxxx", totalPrice: 599000)))
    }
}
