//
//  HomeView.swift
//  AppleStore
//
//  Created by KangHo Kim on 2023/09/05.
//

import SwiftUI

struct Product: Identifiable {
    let id: String = UUID().uuidString // 고유 Product id값
    let name: String // 상품 이름
    let description: String // 상품 간단한 정보
    let price: Int // (시작가 및 가격)
    let imageURLString: String // (배너 이미지)
//    var imageURL: URL {
//        get {
//            return URL(string: imageURLString)!
//        }
//    } // 연산 프로퍼티 필요시 가져다 쓸것
    var detailImageStrings: [String]? // 상세 페이지 전용 이미지 주소 배열
}

// 제품별로 쇼핑하기 부분의 대분류
struct ProductsCategory: Identifiable {
    let id: String = UUID().uuidString // 대분류 id 값
    let name: String // 분류 명
    let imageURLString: String // 분류 대표 이미지 주소
    var products: [Product] // 제품의 배열 값
    // var accessories: [Accessory] // 2주차 경과 보고 진행 (추가사항)
}

let rowSpacing: CGFloat = 20
var gridLayout: [GridItem] {
  return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
}

/// products 더미 데이터
let products: [Product] = [
    Product(name: "iPhone 14", description: "iPhone 14 Pro보다는 떨어지지만 그에 못지 않는 성능. Dynamic 어쩌구. A16 Bionic은 같은.", price: 1250000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-compare-iphone-14-202209?wid=364&hei=508&fmt=jpeg&qlt=90&.v=1660759995969"),
    Product(name: "iPhone 13", description: "이거 그린이 예쁜. 설명할 때 ~입니다로 안 끝나고 ~한, ~은으로 끝나는건 어디서 배워먹은?", price: 950000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-mini-green-witb-202203?wid=328&hei=784&fmt=jpeg&qlt=90&.v=1644964732550"),
    Product(name: "iPhone SE", description: "놀라운 성능. 합리적인 선택. 이 모든 것을 손에 착 감기는 11.9cm 디자인 안에. 솔직히 돈 더 있으면 iPhone 14 Pro.", price: 650000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-se-midnight-witb-202203?wid=380&hei=784&fmt=jpeg&qlt=90&.v=1644951336059")
]

// var RecommendedProducts: [Product]
/// ProductsCategories 더미 데이터
let ProductsCategories: [ProductsCategory] = [
    ProductsCategory(
        name: "iPhone",
        imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-deeppurple-witb-202209?wid=346&hei=784&fmt=jpeg&qlt=90&.v=1660789320288",
        products: [
            Product(name: "iPhone 14", description: "iPhone 14 Pro보다는 떨어지지만 그에 못지 않는 성능. Dynamic 어쩌구. A16 Bionic은 같은.", price: 1250000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-compare-iphone-14-202209?wid=364&hei=508&fmt=jpeg&qlt=90&.v=1660759995969"),
            Product(name: "iPhone 13", description: "이거 그린이 예쁜. 설명할 때 ~입니다로 안 끝나고 ~한, ~은으로 끝나는건 어디서 배워먹은?", price: 950000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-mini-green-witb-202203?wid=328&hei=784&fmt=jpeg&qlt=90&.v=1644964732550"),
            Product(name: "iPhone SE", description: "놀라운 성능. 합리적인 선택. 이 모든 것을 손에 착 감기는 11.9cm 디자인 안에. 솔직히 돈 더 있으면 iPhone 14 Pro.", price: 650000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-se-midnight-witb-202203?wid=380&hei=784&fmt=jpeg&qlt=90&.v=1644951336059")
    ]),
    ProductsCategory(
        name: "iPad",
        imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-comp-air-202210?wid=338&hei=386&fmt=jpeg&qlt=90&.v=1664411153129",
        products: [
            Product(name: "iPad Pro", description: "압도적인 성능. 초고속 무선 연결. 궁극의 iPad 경험", price: 1249000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-comp-pro-202210?wid=338&hei=386&fmt=jpeg&qlt=90&.v=1664411153112"),
            Product(name: "iPad Air", description: "얇고 가벼운 디자인. 결코 가볍지 않은 성능", price: 929000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-comp-air-202210?wid=338&hei=386&fmt=jpeg&qlt=90&.v=1664411153129"),
            Product(name: "iPad", description: "다양한 일상 작업에 맞는 완전히 새롭고, 컬러풀한 iPad", price: 679000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-comp-10thgen-202210?wid=338&hei=386&fmt=jpeg&qlt=90&.v=1664411152951"),
            Product(name: "iPad mini", description: "한 손에 쏙 들어오는 손색없는 iPad 경험.", price: 769000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-comp-mini-202210?wid=338&hei=386&fmt=jpeg&qlt=90&.v=1664411153122")
        ])
]

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height
 
struct HomeView: View {
    @StateObject private var itemStore: ItemStore = ItemStore()
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @State var isShowingProductDetailView: Bool = false
    @State var isTappingBuyButton: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack{
//                    NavigationLink {
//                        Text("ProductDetailView")
//                    } label: {
//                        VStack {
//                            AsyncImage(url: URL(string: "https://www.apple.com/v/iphone-14-pro/h/images/key-features/features/dynamic-island/dynamic_island_deep_purple__exowosw6732a_large_2x.jpg")) { image in
//                                image
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .padding()
//                            } placeholder: {
//                                ProgressView()
//                            }//:AsyncImage
//                        }//:VStack
//                    }
                    Button {
                        isShowingProductDetailView = true
                    } label: {
                        VStack {
                            AsyncImage(url: URL(string: "https://www.apple.com/v/iphone-14-pro/h/images/key-features/features/dynamic-island/dynamic_island_deep_purple__exowosw6732a_large_2x.jpg")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding()
                            } placeholder: {
                                ProgressView()
                            }//:AsyncImage
                        }//:VStack
                    }

                    VStack {
                        VStack(alignment: .leading) {
                            Text("NEW")
                                .foregroundColor(Color.gray)
                                .font(.footnote)
                                .fontWeight(.bold)
                            Text("iPhone 14 Pro")
                                .foregroundColor(Color.white)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding(.bottom, 5)
                            Text("iPhone을 완전히 새로운 방식으로 다룰 수 있게 해주는 Dynamic Island. 혁신적인 48MP 카메라. 여기에 A16 Bionic까지.")
                                .foregroundColor(Color.white)
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                        }
                        Spacer()
                        HStack {
                            Text("1,550,000원부터")
                                .foregroundColor(.white)
                                .font(.subheadline)
                            Spacer()
//                          테스트를 위해 매개변수를 담아놨으며 추후 수정필요
//                          충돌나면 죄송합니다.
                            NavigationLink {
                                PurchaseiPadView(itemStore: itemStore, seriesName: "iPad Air")
                            } label: {
                                Text("구입하기")
                                    .fontWeight(.bold)
                            }
                            .buttonStyle(.bordered)
                            .cornerRadius(30)
                        } // HStack
                        .padding()
                        .background(Color(.sRGB,red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1))
                    } // VStack
                } // ZStack
                .mainViewSectionHeight()
                .background(Color.black)
                ZStack{
                    NavigationLink {
                        Text("ProductDetailView")
                    } label: {
                        AsyncImage(url: URL(string: "https://www.apple.com/kr/macbook-air-13-and-15-m2/b/images/overview/routers/trade_in__f88qe6u6wpea_large_2x.jpg")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("NEW")
                                    .foregroundColor(Color.gray)
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                Text("Macbook Air 15")
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 5)
                                Text("크게 펼치고, 얇게 접다. 지금 만나보세요")
                                    .font(.system(size: 16))
                            }
                            .padding(.horizontal)
                            Spacer()
                        }
                        Spacer()
                        HStack {
                            Text("1,550,000원부터")
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
                        .background(Color(.sRGB,red: 150/255, green: 150/255, blue: 150/255, opacity: 0))
                    } // VStack
                } // ZStack
                .mainViewSectionHeight()
                Divider()
                VStack(alignment: .leading) {
                    Text("추천")
                        .mainViewSectionTitle()
                    RecommendedProductsView(products: products)
                        .padding(.horizontal)
                        .frame(height: (UIScreen.main.bounds.size.height - (safeAreaInsets.top + safeAreaInsets.bottom * 2 + UITabBarController().height)) * 0.85)
                    Spacer()
                } // VStack
                .mainViewSectionHeight()
                VStack(alignment: .leading) {
                    Text("제품별로 쇼핑하기")
                        .mainViewSectionTitle()
                    LazyVGrid(columns: gridLayout, spacing: 20, content: {
                        ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                            NavigationLink {
                                CategoryDetailView()
                            } label: {
                                CategoryView()
                            }
                        }
                    })
                    .padding()
                }
            }
            .listStyle(.plain)
            .navigationTitle("쇼핑하기")
            .fullScreenCover(isPresented: $isShowingProductDetailView) {
                ProductDetailView(isShowingDetailView: $isShowingProductDetailView)
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .tabItem {
            Image(systemName: "ipad.and.iphone")
            Text("쇼핑하기")
        }
//        .onAppear {
//            itemStore.fetchItems()
//        }
    }
}

struct MainViewSectionHeight: ViewModifier {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    func body(content: Content) -> some View {
        content
            .frame(width: screenWidth
                   ,height: screenHeight - (safeAreaInsets.top + safeAreaInsets.bottom * 2 + UITabBarController().height))
            .padding(.top, 24)
    }
}

struct MainViewSectionTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .fontWeight(.semibold)
            .padding(.bottom, 5)
            .padding(.horizontal)
//            .padding()
//            .background(.quaternary, in: Capsule())

    }
}

extension View {
    func mainViewSectionHeight() -> some View {
        modifier(MainViewSectionHeight())
    }
    func mainViewSectionTitle() -> some View {
        modifier(MainViewSectionTitle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
