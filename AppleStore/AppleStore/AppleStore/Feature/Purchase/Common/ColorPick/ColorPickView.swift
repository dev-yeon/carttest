//
//  ColorPickView.swift
//  AppleStore
//
//  Created by SIKim on 2023/09/06.
//

import SwiftUI

struct ColorPickView: View {
    @ObservedObject var itemStore: ItemStore
    
    @State private var selectedTabIndex: [String: Bool] = [:]
    
    var body: some View {
        VStack {
            HStack {
                ///아이폰일 경우
                Text("색상.")
                ///아이패드일 경우
//                Text("마감.")
                    .fontWeight(.bold)
                    ///아이폰일 경우
                Text("맘에 드는 색상을 선택하세요.")
                ///아이패드일 경우
//                Text("애플 이벤트 때문에 확인 못함")
                Spacer()
            }
            .padding()
            .font(.title2)
            
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 15), GridItem(.flexible(), spacing: 15)]) {
                ForEach(Array(itemStore.productColorSet).sorted(), id: \.self) { productColor in
                    ColorButtonView(colorName: productColor)
                        .onTapGesture {
                            for color in itemStore.productColorSet {
                                selectedTabIndex[color] = (color == productColor)
                            }
                            itemStore.productColor = productColor
                            print("\(itemStore.selectedItems)")
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(selectedTabIndex[productColor] ?? false ? Color.blue : Color(.systemGray3), lineWidth: selectedTabIndex[productColor] ?? false ? 3 : 1)
                        )
                }
            }
            .padding(.horizontal)
            
            ///아이폰일 경우에만 보여지는 부분
            VStack {
                AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/Product_Red.svg/2560px-Product_Red.svg.png")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 20)
                } placeholder: {
                    Image(systemName: "xmark.app")
                }

                Text("지금부터 iPhone 14 (PRODUCT)RED 모델이 판매될 때마다 판매 금액의 일부가 코로나19 퇴치를 위한 범세계 기금에 기부됩니‍다‍.‍◊◊◊。")
                    .font(.caption)
                    .padding(.horizontal)
            }
            .padding(.vertical, 30)
        }
    }
}

struct ColorPickView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickView(itemStore: ItemStore())
    }
}
