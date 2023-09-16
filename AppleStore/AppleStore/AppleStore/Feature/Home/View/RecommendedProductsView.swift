//
//  RecommendedProductsView.swift
//  AppleStore
//
//  Created by KangHo Kim on 2023/09/06.
//

import SwiftUI

struct RecommendedProductsView: View {
    // MARK: - PROPERTIES
    @Binding var isShowingProductDetailView: Bool 
    @Binding var product: Product
    
    var products: [Product]
    private let cardWidth = screenWidth - 40
    private let cardHeight = CGFloat(500) // UIScreen.main.bounds.size.height * 0.7

    // MARK: - BODY
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center) {
                ForEach(products) { product in
                        ZStack{
                            VStack {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("NEW")
                                            .foregroundColor(Color.gray)
                                            .font(.footnote)
                                            .fontWeight(.bold)
                                        Text("\(product.name)")
                                            .foregroundColor(.black)
                                            .font(.largeTitle)
                                            .fontWeight(.semibold)
                                            .padding(.bottom, 5)
                                        Text("\(product.description)")
                                            .foregroundColor(.black)
                                            .font(.system(size: 16))
                                            .lineLimit(3)
                                    }
                                    .padding(.horizontal)
                                    Spacer()
                                }
                                Spacer()
                                HStack {
                                    Text("₩\(product.price) 부터")
                                        .font(.subheadline)
                                    Spacer()
                                    NavigationLink {
                                        Text("미구현")
                                    } label: {
                                        Text("구입하기")
                                            .fontWeight(.bold)
                                    }
                                    .buttonStyle(.bordered)
                                    .cornerRadius(30)
                                } // HStack
                                .padding()
                                .background(.gray)
                            } // VStack
                            .padding(.top)
                            .background(Rectangle())
                            .foregroundColor(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                            .padding()
                            Button {
                                isShowingProductDetailView.toggle()
                                self.product = product
                            } label: {
                                AsyncImage(url: URL(string: "\(product.imageURLString)")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 200)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        } // ZStack
                        .frame(width: cardWidth)
                    } // ForEach
            } // HStack
        } //: Scroll
    }
}

struct RecommendedProductsView_Previews: PreviewProvider {
    private static let products: [Product] = [
        Product(name: "iPhone 14 Pro", description: "항공우주 등급 티타늄 디자인을 갖춘 최초의 iPhone. 게임의 판도를 바꾸는 A17 Pro 칩. 맞춤형 ‘동작’ 버튼. iPhone 사상 가장 강력한 카메라 시스템. 여기에 초고속 전송 속도를 자랑하는 USB 3 규격 USB-C까지.*", price: 1550000, imageURLString: "https://www.apple.com/kr/iphone-15-pro/a/images/overview/closer-look/all_colors__eppfcocn9mky_small_2x.jpg", detailWebURLString: "https://www.apple.com/kr/iphone-15-pro/"),
        Product(name: "iPhone 14", description: "iPhone 15 Pro보다는 떨어지지만 그에 못지 않는 성능. Dynamic 어쩌구. 초고해상도 사진 어쩌구. 컬러 인퓨즈 글래스, 알루미늄 디자인.", price: 1250000, imageURLString: "https://www.apple.com/v/iphone-15/a/images/overview/contrast/iphone_15__dozjxuchowcy_small_2x.jpg", detailWebURLString: "https://www.apple.com/kr/iphone-15/"),
        Product(name: "iPhone 13", description: "이거 그린이 예쁜. 설명할 때 ~입니다로 안 끝나고 ~한, ~은으로 끝나는건 어디서 배워먹은?", price: 950000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-mini-green-witb-202203?wid=328&hei=784&fmt=jpeg&qlt=90&.v=1644964732550", detailWebURLString: "https://www.apple.com/kr/shop/buy-iphone/iphone-13"),
        Product(name: "iPhone SE", description: "놀라운 성능. 합리적인 선택. 이 모든 것을 손에 착 감기는 11.9cm 디자인 안에. 솔직히 돈 더 있으면 iPhone 14 Pro.", price: 650000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-se-midnight-witb-202203?wid=380&hei=784&fmt=jpeg&qlt=90&.v=1644951336059", detailWebURLString: "https://www.apple.com/kr/iphone-se/")
    ]
    
    static var previews: some View {
        NavigationView {
            RecommendedProductsView(isShowingProductDetailView: .constant(false), product: .constant(CategoryDetailView_Previews.productsExample[0]), products: products)
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
