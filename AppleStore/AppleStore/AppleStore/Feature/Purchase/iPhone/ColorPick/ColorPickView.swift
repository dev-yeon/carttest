//
//  ColorPickView.swift
//  AppleStore
//
//  Created by SIKim on 2023/09/06.
//

import SwiftUI

struct ColorPickView: View {
    @ObservedObject var itemStore: ItemStore
    @State var productColors: [String] = []
    @State var isCheckButton: [Bool] = []
    @Binding var isCheckButtonActive: Bool
    var body: some View {
        VStack {
            HStack {
                Text("색상.")
                    .fontWeight(.bold)
                Text("맘에 드는 색상을 선택하세요.")
                Spacer()
            }
            .padding()
            .font(.title2)
            
            Grid {
                ForEach(0..<((productColors.count + 1) / 2), id: \.self) { i in
                    GridRow {
                        ForEach(0..<2) { j in
                            if i * 2 + j < productColors.count {
                                ColorButtonView(
                                    colorName: $productColors[i * 2 + j],
                                    isCheckButton: $isCheckButton[i * 2 + j])
                                .onTapGesture {
                                    isCheckButtonActive = true
                                    for k in 0..<productColors.count {
                                        if k == i * 2 + j {
                                            isCheckButton[k] = true
                                            itemStore.userPickItem.productColor = itemStore.itemInfo.productColors[k]
                                            for l in 0..<itemStore.itemInfo.mainImageStrings.count {
                                                if let value = itemStore.itemInfo.mainImageStrings[l][itemStore.userPickItem.productName + itemStore.userPickItem.productColor] {
                                                    itemStore.userPickItem.mainImageString = value
                                                }
                                            }
                                        } else {
                                            isCheckButton[k] = false
                                        }
                                    }
                                    print("\(itemStore.userPickItem)")
                                }
                                .padding([j == 0 ? .leading : .trailing])
                            }
                        }
                    }
                }
            }
            if itemStore.itemInfo.itemType == "iPhone" {
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
        .onAppear {
            for i in 0..<itemStore.itemInfo.productColors.count {
                productColors.append(itemStore.itemInfo.productColors[i])
                isCheckButton.append(false)
            }
        }
    }
}

struct ColorPickView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickView(itemStore: ItemStore(), isCheckButtonActive: .constant(false))
    }
}
