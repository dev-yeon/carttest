//
//  ModelPickView.swift
//  AppleStore
//
//  Created by SIKim on 2023/09/05.
//

import SwiftUI

struct ModelPickView: View {
    @ObservedObject var itemStore: ItemStore
    
    @State private var productNames: [String] = []
    @State private var prices: [Int] = []
    
    @State var isCheckButton: [Bool] = []
    @Binding var isCheckButtonActive: Bool
    @Binding var isCheckStorageButtonActive: Bool
    @Binding var isCheckStorageButton: [Bool]
    @Binding var storages: [String]
    @Binding var pricesAboutStorages: [Int]
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("모델.")
                    .fontWeight(.bold)
                Text(itemStore.itemInfo.itemType == "iPhone" ? "당신에게 딱 맞는 모델은?" : "원하는 사이즈와 디스플레이를 선택하세요.")
                Spacer()
            }
            .padding()
            .font(.title2)
            ForEach(0..<productNames.count, id: \.self) { index in
                ModelButtonView(
                    productName: $productNames[index],
                    price: $prices[index],
                    isCheckButton: $isCheckButton[index]
                )
                .onTapGesture {
                    isCheckButtonActive = true
                    isCheckStorageButtonActive = false
                    for i in 0..<isCheckButton.count {
                        if i == index {
                            isCheckButton[i] = true
                            itemStore.userPickItem.productName = productNames[i]
                            for j in 0..<itemStore.itemInfo.mainImageStrings.count {
                                if let value = itemStore.itemInfo.mainImageStrings[j][productNames[i]] {
                                    itemStore.userPickItem.mainImageString = value
                                }
                            }
//                            itemStore.userPickItem.price = prices[i]
//                            itemStore.userPickItem.mainImageString = productNames[i] + itemStore.userPickItem.productColor
                        } else {
                            isCheckButton[i] = false
                        }
                    }
                    itemStore.updateStorageButton(storages: &storages, prices: &pricesAboutStorages, isCheckButton: &isCheckStorageButton)
                    print("\(itemStore.userPickItem)")
                }
            }
        }
        .onAppear {
            print("모델픽뷰")
            for i in 0..<itemStore.itemInfo.prices.count {
                for (key, value) in itemStore.itemInfo.prices[i] {
                    for j in 0..<itemStore.itemInfo.productNames.count {
                        if key == itemStore.itemInfo.productNames[j] {
                            productNames.append(key)
                            prices.append(value)
                            isCheckButton.append(false)
                            print("\(key)")
                        }
                    }
                }
            }
        }
    }
}

struct ModelPickView_Previews: PreviewProvider {
    static var previews: some View {
        ModelPickView(itemStore: ItemStore(), isCheckButtonActive: .constant(false), isCheckStorageButtonActive: .constant(false), isCheckStorageButton: .constant([]), storages: .constant([]), pricesAboutStorages: .constant([]))
    }
}
