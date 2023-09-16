//
//  bankAccountNumberView.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/09.
//

import SwiftUI

struct BankAccountNumberView: View {
    let bankAccountNumber: String
    @Binding var isCopied: Bool
    
    var body: some View {
        VStack {
            Text("입금계좌")
                .font(.body)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(lineWidth: 0.3)
                    .foregroundColor(.gray)
                    .frame(height: 50)
                HStack {
                    Spacer()
                    
                    Text("\(bankAccountNumber)")
                        .font(.title2)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    Divider()
                        .frame(height: 50)
                    
                    Button {
                        isCopied = true
                    } label: {
                        Text("복사하기")
                    }
                    .padding(.horizontal)
                }
            }
            
            Text("24시간내 미입금 또는 상품 품절시 주문 자동 취소")
                .font(.caption)
        }
    }
}

struct BankAccountNumberView_Previews: PreviewProvider {
    static var previews: some View {
        BankAccountNumberView(bankAccountNumber: "xxxx-xx-xxxxxxx", isCopied: .constant(false))
    }
}
