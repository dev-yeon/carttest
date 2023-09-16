//
//  ProductDetailView.swift
//  AppleStore
//
//  Created by KangHo Kim on 2023/09/11.
//

import SwiftUI
import WebKit

struct ProductDetailView: View {
    
    @Binding var isPurchaseTapped: Bool
    @Binding var isShowingDetailView: Bool
    @State var isAnimating: Bool = false
    @State private var webView = WKWebView()
    
    let product: Product
            
    var body: some View {
        ZStack(alignment: .topTrailing) {
            WebView(urlString: "\(product.detailWebURLString)")
            Button {
                isShowingDetailView = false                
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .font(.title)
            }
            .padding(24)
            
        }
        .overlay (
            Group {
                HStack {
                    Text("\(product.price) 원부터")
                        .font(.subheadline)
                    Spacer()
                    Button {
                        isShowingDetailView = false
                        isPurchaseTapped = true
                    } label: {
                        Text("구입하기")
                            .fontWeight(.bold)
                    }
                    .buttonStyle(.bordered)
//                    .tint(.white)
                    .cornerRadius(30)
                }//:HStack
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .padding()
                .padding(.bottom)
                .offset(y: isAnimating ? 0 : 130)
                .animation(
                    Animation.spring(
                        response: 0.3,
                        dampingFraction: 0.5,
                        blendDuration: 1.0)
                    , value: isAnimating)
            }
            , alignment: .bottom
        )
        .statusBar(hidden: true)
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                isAnimating = true
            })
        })
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(isPurchaseTapped: .constant(false) ,isShowingDetailView: .constant(true), product: CategoryDetailView_Previews.productsExample[0])
            .edgesIgnoringSafeArea(.top)
    }
}
