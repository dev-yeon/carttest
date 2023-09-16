//
//  PriceTopView.swift
//  AppleStore
//
//  Created by SIKim on 2023/09/07.
//

import SwiftUI

struct PriceTopView: View {
    @ObservedObject var itemStore: ItemStore
    var body: some View {
        Text("₩\(itemStore.userPickItem.price)")
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
