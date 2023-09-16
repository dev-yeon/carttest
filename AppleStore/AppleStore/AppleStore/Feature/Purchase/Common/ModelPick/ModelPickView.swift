//
//  ModelPickView.swift
//  AppleStore
//
//  Created by SIKim on 2023/09/05.
//
import SwiftUI

struct ModelPickView: View {
    @ObservedObject var itemStore: ItemStore
    
    @State private var selectedTabIndex: [String: Bool] = [:]
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("모델.")
                    .fontWeight(.bold)
                ///아이폰 종류일 경우
                Text("당신에게 딱 맞는 모델은?")
                ///아이패드 종류일 경우
                Spacer()
            }
            .padding()
            .font(.title2)
            
            ForEach(Array(itemStore.productNameSet).sorted(), id: \.self) { productName in
                ModelButtonView(productName: productName)
                    .onTapGesture {
                        for name in itemStore.productNameSet {
                            selectedTabIndex[name] = (name == productName)
                        }
                        itemStore.productName = productName
                        print("\(itemStore.selectedItems)")
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(selectedTabIndex[productName] ?? false ? Color.blue : Color(.systemGray3), lineWidth: selectedTabIndex[productName] ?? false ? 3 : 1)
                    )
                    .padding(.horizontal)
            }
        }
    }
}

struct ModelPickView_Previews: PreviewProvider {
    static var previews: some View {
        ModelPickView(itemStore: ItemStore())
    }
}
