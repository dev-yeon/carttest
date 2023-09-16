//
//  PriceTopView.swift
//  AppleStore
//
//  Created by SIKim on 2023/09/07.
//

import SwiftUI

struct PriceTopView: View {
    @ObservedObject var itemStore: ItemStore
    private var price: Int {
        guard !itemStore.selectedItems.isEmpty else { return 0}
        if itemStore.selectedItems.count == 1 {
            return itemStore.selectedItems[0].price
        } else {
            return 0
        }
    }
    var body: some View {
            Text("₩\(price)")
                .font(.footnote)
                .frame(width: 400, height: 45)
                .border(Color(.systemGray5))
    }
}

struct PriceTopView_Previews: PreviewProvider {
    static var previews: some View {
        PriceTopView(itemStore: ItemStore())
    }
}
