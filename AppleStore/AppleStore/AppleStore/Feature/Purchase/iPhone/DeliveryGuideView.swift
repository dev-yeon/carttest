//
//  DeliveryGuideView.swift
//  AppleStore
//
//  Created by SIKim on 2023/09/06.
//

import SwiftUI

struct DeliveryGuideView: View {
    var body: some View {
        Group {
            HStack {
                Image(systemName: "shippingbox")
                    .padding()
                Text("빠른 무료 배송")
                Spacer()
            }
            HStack {
                Image(systemName: "shippingbox.and.arrow.backward")
                    .padding()
                Text("무료로 손쉽게 반품")
                Spacer()
            }
        }
        .font(.caption)
    }
}

struct DeliveryGuideView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryGuideView()
    }
}
