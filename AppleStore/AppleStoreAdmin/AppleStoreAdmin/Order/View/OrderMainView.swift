//
//  OrderMainView.swift
//  AppleStoreAdmin
//
//  Created by 김유진 on 2023/09/06.
//

import SwiftUI

struct OrderMainView: View {
    
    @StateObject var orderStore: OrderStore = OrderStore()
    
    @State private var selectedOrderStatus: OrderStatus = .complete
    
    var body: some View {
        
        NavigationStack {
            Picker("주문 상태", selection: $selectedOrderStatus) {
                ForEach(OrderStatus.allCases, id: \.self) { status in
                    if status == .complete {
                        Text("전체")
                    }
                    else if status != .cancle {
                        Text(status.rawValue)
                    }
                }
            }
            .onChange(of: selectedOrderStatus) { status in
                if status == .complete {
                    orderStore.fetchAll()
                }
                else {
                    orderStore.fetchState(state: status.rawValue)
                }

            }
            .pickerStyle(.segmented)
            .padding()
            
            OrderTableView(orderStore: orderStore)
                .tableStyle(.automatic)
                .refreshable {
                    orderStore.fetchAll()
                    if selectedOrderStatus == .complete {
                        orderStore.fetchAll()
                    }
                    else {
                        orderStore.fetchState(state: selectedOrderStatus.rawValue)
                    }
                }
        }
        .onAppear {
            if selectedOrderStatus == .complete {
                orderStore.fetchAll()
            }
            else {
                orderStore.fetchState(state: selectedOrderStatus.rawValue)
            }
        }
    }
}

