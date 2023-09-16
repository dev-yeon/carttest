//
//  ProductContentsView.swift
//  AppleStore
//
//  Created by SIKim on 2023/09/06.
//

import SwiftUI

struct ProductContentsView: View {
    @ObservedObject var itemStore: ItemStore
    private var imageURLString: String {
        guard !itemStore.selectedItems.isEmpty else { return ""}
        return itemStore.selectedItems[0].mainImageString
    }
    var body: some View {
        //바디 내에는 최상단 뷰를 놓고 처리하는 것이 좋음.
        VStack {
            HStack {
                Text("제품 구성")
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            .font(.title2)
            
            TabView {
                VStack {
                    AsyncImage(url: URL(string: imageURLString)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Image(systemName: "xmark.app")
                    }
                    Text("iPhone")
                        .font(.footnote)
                        .padding()
                    //                .padding(.horizontal, 110)
                }
                VStack {
                    AsyncImage(url: URL(string: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-cables-witb-202209?wid=92&hei=392&fmt=jpeg&qlt=95&.v=1660679135172")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Image(systemName: "xmark.app")
                    }
                    //                .padding(.horizontal, 140)
                    Text("USB-C-Lightning 케이블")
                        .font(.footnote)
                        .padding()
                    
                }
            }
            .frame(maxWidth: .infinity, minHeight: 400)
            .background(Color(.systemGray6).opacity(0.3))
            //페이지 인디케이터 삭제
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack(alignment: .center) {
                Text("환경 보호를 위한 Apple의 목표.")
                Text("2030년까지 탄소중립성을 달성하기 위한 Apple의 지속적인 노력의 일환으로 iPhone 14 및 iPhone 14 Plus 제품 구성에는 전원 어댑터 및 EarPods이 포함되지 않습니다. 대신 급속 충전을 지원하고 USB‑C 전원 어댑터 및 컴퓨터 포트와 호환되는 USB-C-Lightning 케이블은 포함되어 있습니다.\n")
                Text("기존에 사용 중이던 USB‑A-Lightning 케이블, 전원 어댑터, 헤드폰이 이 iPhone 모델과 호환된다면 계속 사용하시길 권장합니다. 하지만 새로운 Apple 전원 어댑터 또는 헤드폰이 필요하다면 원하시는 제품을 구입할 수 있습니다.")
            }
            .font(.caption)
            .padding()
        }
    }
}

struct ProductContentsView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ProductContentsView(itemStore: ItemStore())
        }
    }
}
