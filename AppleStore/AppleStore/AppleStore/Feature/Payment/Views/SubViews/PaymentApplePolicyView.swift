//
//  ApplePolicyView.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/09.
//

import SwiftUI

struct PaymentApplePolicyView: View {
    @State var isCheckAgree: Bool = false
    @State var isShowingApplePolicySheet: Bool = false
    
    @Binding var isDisablePaymetButton: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Apple 정책에 따라 개인 정보를 수집, 사용, 처리 및 전송할 수 있다 는 데 동의합니다.")
                .font(.caption)
                .foregroundColor(.gray)
            Button {
                isShowingApplePolicySheet = true
            } label: {
                Text("Apple 정책에 대해 더 알아보기")
                    .font(.caption)
            }
            .padding(.bottom)
            
            
            Button {
                isCheckAgree.toggle()
                isDisablePaymetButton = false
            } label: {
                HStack {
                    Image(systemName: isCheckAgree ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(.blue)
                    Text("동의함")
                        .foregroundColor(.black)
                }
            }
        }
        .sheet(isPresented: $isShowingApplePolicySheet) {
            SupportSafariView(siteURL: "https://www.apple.com/kr/legal/privacy/kr/")
        }
    }
}

struct ApplePolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentApplePolicyView(isDisablePaymetButton: .constant(true))
    }
}
