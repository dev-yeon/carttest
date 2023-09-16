//
//  TotalAmountsView.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/07.
//

import SwiftUI

struct PaymentTotalPriceView: View {
    let totalPrice: Int
    
    var body: some View {
        Grid {
            GridRow(alignment: .top) {
                Text("요약")
                    .frame(width: 80, alignment: .leading)
                
                Grid(alignment: .leading) {
                    GridRow {
                        Text("장바구니 소계")
                        Text("₩\(totalPrice)")
                    }
                    .padding(.bottom,8)
                    
                    GridRow {
                        Text("무료 배송")
                        Text("₩0")
                    }
                    .padding(.bottom,8)
                    
                    Divider()
                    
                    GridRow {
                        Text("총 주문")
                        Text("₩\(totalPrice)")
                    }
                    .padding(.vertical, 4)
                }
                .padding(.horizontal, 8)
            }
        }
    }
}

struct TotalAmountsView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentTotalPriceView(totalPrice: 999999)
    }
}
