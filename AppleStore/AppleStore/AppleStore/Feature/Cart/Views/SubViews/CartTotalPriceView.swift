//
//  CartTotalPriceView.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/13.
//

import SwiftUI

struct CartTotalPriceView: View {
    let totalPrice: Int
    
    var body: some View {
        VStack {
            HStack {
                Text("장바구니 소계")
                Spacer()
                Text("₩\(totalPrice)")
            }
            .padding(.vertical, 5)
            Divider()
            HStack {
                Text("다음 부가가치세 포함")
                Spacer()
                Text("₩\(Int (Double(totalPrice) * 0.11))")
            }
            .padding(.vertical, 5)
            Text("무료 배송 혜택을 이용할 수 있는 장바구니입니다.")
                .font(.caption2)
                .foregroundColor(.gray)
            .padding(.vertical, 5)
        }
    }
}

struct CartTotalPriceView_Previews: PreviewProvider {
    static var previews: some View {
        CartTotalPriceView(totalPrice: 999999)
    }
}
