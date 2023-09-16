//
//  ManagementButtons.swift
//  AppleStoreAdmin
//
//  Created by 김유진 on 2023/09/06.
//

import SwiftUI

struct OrderCancleButton: View {
    @Binding var isShowingCancleAlert: Bool
    @State var order: Order
    @StateObject var orderStore: OrderStore
    
    var body: some View {
        Button {
            isShowingCancleAlert = true
        } label: {
            Text("주문 취소")
        }
        .buttonStyle(.bordered)
        .foregroundColor(.red)
        .alert(isPresented: $isShowingCancleAlert, content: {
            let firstButton = Alert.Button.destructive(Text("네")) {
                orderStore.editOrder(order: order, orderStatus: .cancle)
            }
            
            return Alert(title: Text("주문을 취소하겠습니까?"), primaryButton: firstButton , secondaryButton: .cancel(Text("아니오")))
        })
    }
}
