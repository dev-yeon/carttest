//
//  EmptyCartView.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/13.
//

import SwiftUI

struct EmptyCartView: View {
    @EnvironmentObject var cartItemStore: CartItemStore
    
    var body: some View {
        VStack {
            Image(systemName: "bag")
                .font(.system(size: 100))
                .foregroundColor(.gray)
                .padding(.bottom, 12)
            Text("장바구니가 비어 있습니다.")
                .font(.title)
                .bold()
                .padding(.bottom, 4)
            Text("계속 Apple Store를 둘러보거나 이전에")
                .foregroundColor(.gray)
            Text("저장해둔 제품을 구입하세요.")
                .foregroundColor(.gray)
            // 테스트 버튼
//            Button {
//                cartItemStore.addOneItemToCart(item: Item(seriesName: "", productName: "iPad Pro", price: 2299000, mainImageString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-pro-payment-apple-care-plus-summary-202212-11inch-silver-wifi?wid=5120&hei=2880&fmt=p-jpg&qlt=95&.v=1667596427272", productColor: "실버", storage: "1TB", status: 0, inchModel: "11", embedCellular: "Wi-Fi"))
//            } label: {
//                Text("장바구니에 담기")
//                    .frame(maxWidth: .greatestFiniteMagnitude)
//            }
        }
    }
}

struct EmptyCartView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyCartView()
    }
}
