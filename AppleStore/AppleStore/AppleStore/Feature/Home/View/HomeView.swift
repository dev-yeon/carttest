//
//  HomeView.swift
//  AppleStore
//
//  Created by KangHo Kim on 2023/09/05.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var itemStore: ItemStore = ItemStore()
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @ObservedObject var productViewModel = ProductViewModel()
    @State private var isShowingProductDetailView: Bool = false
    @State private var isTappingBuyButton: Bool = false
    @State private var isPurchaseTapped: Bool = false
    @State private var shouldPresentPurchaseView = false
    
    // 일단은 초기값으로 static let으로 선언한 아이템을 줌
    @State private var product: Product = CategoryDetailView_Previews.productsExample[0]
    
    let rowSpacing: CGFloat = 20
    var gridLayout: [GridItem] {
        return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
    }
    
    var newIPhone: Product {
        return productViewModel.productCategories[0].products[0]
    }
    
    var newIPad: Product {
        return productViewModel.productCategories[1].products[0]
    }
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack{
                    Button {
                        isShowingProductDetailView = true
                        self.product = newIPhone
                    } label: {
                        VStack {
                            AsyncImage(url: URL(string: "\(newIPhone.imageURLString)")) { image in
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
                            Group {
                                Text("NEW")
                                    .foregroundColor(Color.gray)
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                Text("\(newIPhone.name)")
                                    .foregroundColor(Color.white)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 5)
                                Text("\(newIPhone.description)")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                            }
                            .padding(.horizontal)
                        }
                        Spacer()
                        HStack {
                            Text("₩\(productViewModel.priceString(price: newIPhone.price))부터")
                                .foregroundColor(.white)
                                .font(.subheadline)
                            Spacer()
                            // 테스트를 위해 매개변수를 담아놨으며 추후 수정필요
                            // 충돌나면 죄송합니다.
                            Button {
                                isPurchaseTapped = true
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
                .homeViewSectionHeight()
                .background(Color.black)
                ZStack{
                    Button {
                        isShowingProductDetailView = true
                        self.product = newIPad
                    } label: {
                        AsyncImage(url: URL(string: "\(newIPad.imageURLString)")) { image in
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
                                Text("\(newIPad.name)")
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 5)
                                Text("\(newIPad.description)")
                                    .font(.system(size: 16))
                            }
                            .padding(.horizontal)
                            Spacer()
                        }
                        Spacer()
                        HStack {
                            Text("₩\(productViewModel.priceString(price: newIPad.price))부터")
                                .font(.subheadline)
                            Spacer()
                            NavigationLink { // 아직 구현 안되어 있음
                                PurchaseiPadView(itemStore: itemStore, seriesName: newIPad.name)
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
                .homeViewSectionHeight()
                Divider()
                VStack(alignment: .leading) {
                    Text("추천")
                        .homeViewSectionTitle()
                    RecommendedProductsView(isShowingProductDetailView: $isShowingProductDetailView, product: $product, products: productViewModel.recommendedProducts(products: productViewModel.allProducts))
                        .padding(.horizontal)
                        .frame(height: (UIScreen.main.bounds.size.height - (safeAreaInsets.top + safeAreaInsets.bottom + UITabBarController().height * 2)) * 0.85)
                    Spacer()
                } // VStack
                .homeViewSectionHeight()
                VStack(alignment: .leading) {
                    Text("제품별로 쇼핑하기")
                        .homeViewSectionTitle()
                    LazyVGrid(columns: gridLayout, spacing: 20, content: {
                        ForEach(productViewModel.productCategories) { item in
                            NavigationLink {
                                CategoryDetailView(isShowingProductDetailView: $isShowingProductDetailView, product: $product, products: item.products)
                            } label: {
                                CategoryView(productsCategory: item)
                            }
                        }
                    })
                    .padding()
                }//:VStack
            }//:ScrollView
            .listStyle(.plain)
            .navigationTitle("쇼핑하기")
            .fullScreenCover(isPresented: $isShowingProductDetailView) {
                ProductDetailView(isPurchaseTapped: $isPurchaseTapped, isShowingDetailView: $isShowingProductDetailView, product: self.product)
                    .edgesIgnoringSafeArea(.all)
            }
            .navigationDestination(isPresented: $isPurchaseTapped) {
                PurchaseiPhoneView(itemStore: itemStore, seriesName: newIPhone.name)
            }
        }
        .tabItem {
            Image(systemName: "ipad.and.iphone")
            Text("쇼핑하기")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
