//
//  OrderListView.swift
//  AppleStore
//
//  Created by dayexx on 2023/09/05.
//

import SwiftUI

struct OrderListView: View {
    
    @StateObject private var orderStore: OrderStore = OrderStore()
    
    var body: some View {
        List{
            if(orderStore.orders.isEmpty){
                Text("최근 주문 내역이 없습니다.").bold().foregroundColor(.gray)
                    .padding(EdgeInsets(top:50, leading: 0, bottom: 50, trailing: 0))
            }
            else{
                ForEach(orderStore.orders){ order in
                    NavigationLink {
                        OrderDetailView(order: order, orderStore: orderStore)
                    } label: {
                        OrderCellView(order: order).padding()
                    }
                }
            }
        }
        .navigationTitle("주문")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .onAppear{
            orderStore.fetchOrders()
        }
    }
       
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            OrderListView()
        }
    }
}
