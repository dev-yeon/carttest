//
//  ProductsToBePaidView.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/07.
//

import SwiftUI
import AppleStoreCore

struct ProductsToBePaidView: View {
    @EnvironmentObject var cartItemStore: CartItemStore
    @State var cartItem: CartItem
    @Environment(\.editMode) private var editMode
    @State var amounts = 1
    
    var body: some View {
        Grid(alignment: .leading) {
            // 주문한 아이템
            GridRow {
                AsyncImage(url: cartItem.imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80)
                } placeholder: {
                    ProgressView()
                }
                VStack (alignment: .leading) {
                    Text("\(cartItem.name)")
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.vertical, 3)
                    
//                    if editMode?.wrappedValue.isEditing == true {
//                        Text("수량 : \(cartItem.amount)")
//                        Stepper(value: $amounts, in: 1...100, label: {
//                            Text("\(amounts)")
//                        }, onEditingChanged: { isEditing in
//                            if isEditing {
//                                cartItem.amount = amounts
//                                cartItemStore.updateAmountInCartItem(cartItem: cartItem)
//                            }
//                        })
//
//                                value: Binding(
//                                    get: { cartItem.amount },
//                                    set: { _,_ in cartItemStore.updateAmountInCartItem(cartItem:cartItem) }
//                                ), in: 1...100)
//                    } else {
//                        Text("수량 : \(cartItem.amount)")
//                    }
                }
                
                
                Text("₩\(cartItem.price * cartItem.amount)")
            }
            
            if cartItem.amount > 1 {
                GridRow {
                    Text("수량 : \(cartItem.amount)")
                    Text("항목가격 : ₩\(cartItem.price)")
                }
            }
            
            Divider()
                .padding(.vertical)
            
            
            // 배송일
            GridRow {
                Image(systemName: "box.truck.badge.clock")
                    .foregroundColor(.gray)
                    .frame(width: 80)
                
                VStack(alignment: .leading) {
                    Text("익일")
                    Text("표준 배송 - 무료 배송")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .font(.callout)
    }
}

struct ProductsToBePaidView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsToBePaidView(cartItem: CartItem.sampleCartItem)
    }
}
