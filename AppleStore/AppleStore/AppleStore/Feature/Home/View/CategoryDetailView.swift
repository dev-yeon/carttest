//
//  CategoryDetailView.swift
//  AppleStore
//
//  Created by KangHo Kim on 2023/09/11.
//

import SwiftUI

struct CategoryDetailView: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @Binding var isShowingProductDetailView: Bool
    @Binding var product: Product
    var products: [Product]
    
    var body: some View {
        ScrollView {
            RecommendedProductsView(isShowingProductDetailView: $isShowingProductDetailView, product: $product, products: products)
                .padding(.horizontal)
                .frame(height: (UIScreen.main.bounds.size.height - (safeAreaInsets.top + safeAreaInsets.bottom * 2 + UITabBarController().height)) * 0.85)
            Divider()
            VStack(alignment: .leading) {
    
                Text("무료 배송")
                    .font(.caption)
                Text("집으로 배송 받으세요. 아니면 Apple Store에서 재고 제품을 픽업하세요.")
                    .font(.caption2)
            }
            Divider()
            VStack {
                HStack {
                    Text("iPad에 관해 궁금한\n점이 있으신가요?")
                        .font(.title)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct CategoryDetailView_Previews: PreviewProvider {
    static let productsExample: [Product] = [
        Product(name: "iPhone 15 Pro", description: "항공우주 등급 티타늄 디자인을 갖춘 최초의 iPhone. 게임의 판도를 바꾸는 A17 Pro 칩. 맞춤형 ‘동작’ 버튼. iPhone 사상 가장 강력한 카메라 시스템. 여기에 초고속 전송 속도를 자랑하는 USB 3 규격 USB-C까지.*", price: 1550000, imageURLString: "https://www.apple.com/kr/iphone-15-pro/a/images/overview/closer-look/all_colors__eppfcocn9mky_small_2x.jpg", detailWebURLString: "https://www.apple.com/kr/iphone-15-pro/"),
        Product(name: "iPhone 15", description: "iPhone 15 Pro보다는 떨어지지만 그에 못지 않는 성능. Dynamic 어쩌구. 초고해상도 사진 어쩌구. 컬러 인퓨즈 글래스, 알루미늄 디자인.", price: 1250000, imageURLString: "https://www.apple.com/v/iphone-15/a/images/overview/contrast/iphone_15__dozjxuchowcy_small_2x.jpg", detailWebURLString: "https://www.apple.com/kr/iphone-15/"),
        Product(name: "iPhone 13", description: "이거 그린이 예쁜. 설명할 때 ~입니다로 안 끝나고 ~한, ~은으로 끝나는건 어디서 배워먹은?", price: 950000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-mini-green-witb-202203?wid=328&hei=784&fmt=jpeg&qlt=90&.v=1644964732550", detailWebURLString: "https://www.apple.com/kr/shop/buy-iphone/iphone-13"),
        Product(name: "iPhone SE", description: "놀라운 성능. 합리적인 선택. 이 모든 것을 손에 착 감기는 11.9cm 디자인 안에. 솔직히 돈 더 있으면 iPhone 14 Pro.", price: 650000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-se-midnight-witb-202203?wid=380&hei=784&fmt=jpeg&qlt=90&.v=1644951336059", detailWebURLString: "https://www.apple.com/kr/iphone-se/")
    ]
    static var previews: some View {
        CategoryDetailView(isShowingProductDetailView: .constant(false), product: .constant(CategoryDetailView_Previews.productsExample[0]), products: productsExample)
    }
}
