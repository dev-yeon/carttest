//
//  TermsAndConditionsView.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/07.
//

import SwiftUI

struct PaymentTermsAndConditionsView: View {
    
    var body: some View {
        VStack {
            VStack {
                Text(
                    """
                    '주문하기'를 탭하면 Apple의 판매 및 환불 정책과 개인정보 취급
                    방침의 모든 약관에 동의하는 것으로 간주됩니다.
                    
                    
                    '주문하기'를 탭하면 이니시스를 통해 결제가 진행됩니다.결제가 승
                    인된 후에는 Apple Store 앱으로 돌아갑니다.
                    """
                )
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom)
                
                Text("계정 : \(UserService.shared.currentUser?.email ?? "aaa@gmail.com")")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            VStack(alignment: .center, spacing: 15) {
                Text("Apple 판매 및 환불 정책")
                Text("Apple 개인정보 취급방침")
                Text("Copyright © 2023 Apple Inc. 모든 권리 보유.")
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
            .font(.caption)
        }
    }
}

struct TermsAndConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentTermsAndConditionsView()
    }
}
