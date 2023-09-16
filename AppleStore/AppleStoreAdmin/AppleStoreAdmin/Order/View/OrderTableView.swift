import SwiftUI
import AppleStoreCore

struct OrderTableView: View {
    @ObservedObject var orderStore: OrderStore
    
    @State private var isSelected: Order.ID?
    
    var body: some View {
        
        VStack {
            Table(orderStore.orders, selection: $isSelected) {
                
                TableColumn("주문 번호") { order in
                    Text("\(order.createdOrder)")
                        .bold()
                    Text(order.id)
                }
                .width(max: .infinity)
                
                TableColumn("품목명") { order in
                    HStack{
                        Text("\(order.productName)")
                    }
                }
                .width(max: .infinity)
                
                TableColumn("주문자ID") { order in
                    Text("\(order.uid)")
                }
                
                TableColumn("주문 현황") { order in
                    Text("\(order.state)")
                        .bold()
                }
                .width(100)
                
                TableColumn("상세") { order in
                    Menu {
                        NavigationLink(value: order.id) {
                            Label("주문 상세", systemImage: "list.bullet.below.rectangle")
                        }
                    } label: {
                        Label("상세", systemImage: "ellipsis.circle")
                            .labelStyle(.iconOnly)
                            .contentShape(Rectangle())
                            .tint(.black)
                    }
                    
                }
                .width(100)
            }
            .navigationDestination(for: Order.ID.self) { id in
                if let order = orderStore.getOrder(id: id) {
                    OrderDetailView(orderStore: orderStore, order: order)
                }
            }
        }
    }
}


