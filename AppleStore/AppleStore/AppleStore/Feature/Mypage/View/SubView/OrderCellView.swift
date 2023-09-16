//
//  OrderCellView.swift
//  AppleStore
//
//  Created by dayexx on 2023/09/05.
//

import SwiftUI

struct OrderCellView: View {
    var order : Order
    var body: some View {
        HStack{
            ProductImageView(image: order.imageURLString)
            VStack(alignment: .leading) {
                Spacer()
                Text(order.productName)
                    .bold()
                    .font(.callout)
                Spacer()
                Text("₩ \(order.price)")
                    .font(.footnote)
                Spacer()
            }.padding()
        }
        
    }
}
/*
struct OrderCellView_Previews: PreviewProvider {
    static var previews: some View {
        OrderCellView(order: )
//            .previewLayout(.fixed(width: 400, height: 200))
    }
}*/
