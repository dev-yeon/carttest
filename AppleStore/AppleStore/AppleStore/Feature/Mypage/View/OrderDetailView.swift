//
//  OrderDetailView.swift
//  AppleStore
//
//  Created by dayexx on 2023/09/05.
//

import SwiftUI

struct OrderDetailView: View {
    var order: Order
    @ObservedObject var orderStore : OrderStore
    @State var isShowingAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var name: String {
        UserService.shared.currentUser?.userName ?? ""
    }
    var headAddress: String {
        UserService.shared.currentUser?.headAddress ?? ""
    }
    
    var body: some View {
        List{
            //주문 상품
            OrderCellView(order: order)
                .padding()
            
            //배송현황
            OrderProgressView(order: order).frame(height: 200)
            
            //주소 - 주소 모델링 후 따로 뷰 생성할 예정
            
            VStack(alignment: .leading){
                HStack{
                    Text("배송지").bold().frame(width: 100,alignment: .leading)
                    Text(headAddress).font(.footnote)
                }.padding(5)
                HStack{
                    Text("주문자").bold().frame(width: 100,alignment: .leading)
                    Text(name).font(.footnote)
                }.padding(5)
                HStack{
                    Text("주문날짜").bold().frame(width: 100 ,alignment: .leading)
                    Text(order.createdDate).font(.footnote)
                }.padding(5)
            }.padding()
            
            Button {
                isShowingAlert = true
            } label: {
                HStack{
                    Spacer()
                    Text("주문 취소")
                        .foregroundColor(.blue)
                    Spacer()
                }
            }
            
        }
        .navigationTitle("주문 상세")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .alert(isPresented: $isShowingAlert) {
            Alert(
                title: Text("취소"),
                message: Text("주문을 취소하시겠습니까?"),
                primaryButton:
                        .default(Text("확인")) {
                            orderStore.removeOrder(order)
                            presentationMode.wrappedValue.dismiss()
                        },
                secondaryButton:
                        .cancel(Text("취소")
                            .foregroundColor(.red), action:{}
                        ))
        }
        
        
    }
    
}
