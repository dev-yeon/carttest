//
//  OrderDetailView.swift
//  AppleStoreAdmin
//
//  Created by 김유진 on 2023/09/10.
//

import SwiftUI
import Kingfisher
import AppleStoreCore

struct OrderDetailView: View {
    @ObservedObject var orderStore: OrderStore
    @ObservedObject private var paymentStore = PaymentStore()
    
    @State var order: Order
    
    @State private var isShowingCancleAlert = false
    @State private var isShowingAcceptAlert = false
    @State private var isShowingTrackingNumberAlert = false
    @State private var isShowingTrackingNumberView = false
    @State private var trackingNumber = ""
    @State private var selectedDelivery: deliveryServiceCompanies = .cj
    
    var body: some View {
        VStack {
            
            List {
                Section("주문 번호") {
                    HStack{
                        Text("주문 일시")
                        Spacer()
                        Text(order.createdOrder)
                    }
                    HStack {
                        Text("주문 번호")
                        Spacer()
                        Text(order.id)
                    }
                }
                
                Section("회원 정보") {
                    HStack {
                        Text("ID")
                        Spacer()
                        Text(order.uid)
                    }
                }
                
                Section("주문 상태") {
                    Text(order.state)
                    
                }
                
                Section("주문 상세"){
                    // MARK: receipt -> payment -> prepare -> shipment -> complete
                    
                    let cancleButton = Button {
                            isShowingCancleAlert = true
                        } label: {
                            Text("주문 취소")
                        }
                        .foregroundColor(.red)
                        .alert(isPresented: $isShowingCancleAlert, content: {
                            let firstButton = Alert.Button.destructive(Text("네")) {
                                order.state = OrderStatus.cancle.rawValue
                                orderStore.editOrder(order: order, orderStatus: .cancle)
                            }
                            return Alert(title: Text("주문을 취소하겠습니까?"), primaryButton: firstButton , secondaryButton: .cancel(Text("아니오")))
                        })
                    
                    switch(order.state) {
                    case OrderStatus.cancle.rawValue:
                        Text("취소된 주문")
                            .foregroundColor(.red)
                    case OrderStatus.receipt.rawValue:
                        HStack{
                            Text("결제 요청 정보")
                            Spacer()
                            Text(paymentStore.payment?.bankName ?? "")
                            Text(paymentStore.payment?.bankAccountNumber ?? "")
                        }
                        
                        HStack{
                            Text("결제 요청 가격")
                            Spacer()
                            Text("\(paymentStore.payment?.totalPrice ?? 0)원")
                        }
                        Button {
                            paymentStore.setPaymentIsPayed(payment: paymentStore.payment)
                            order.state = OrderStatus.payment.rawValue
                            orderStore.editOrder(order: order, orderStatus: .payment)
                        } label: {
                            Text("입금 확인")
                        }
                        
                        cancleButton
                        
                    case OrderStatus.payment.rawValue:
                        Button {
                            isShowingAcceptAlert = true
                        } label: {
                            Text("주문 수락")
                        }
                        .alert(isPresented: $isShowingAcceptAlert, content: {
                            let firstButton = Alert.Button.default(Text("네")) {
                                order.state = OrderStatus.prepare.rawValue
                                orderStore.editOrder(order: order, orderStatus: .prepare)
                            }
                            
                            return Alert(title: Text("주문을 수락하시겠습니까?"), primaryButton: firstButton , secondaryButton: .cancel(Text("아니오")))
                        })
                        
                        cancleButton
                        
                    case OrderStatus.prepare.rawValue:
                        if isShowingTrackingNumberView {
                            Picker("택배사를 선택하세요", selection: $selectedDelivery) {
                                ForEach(deliveryServiceCompanies.allCases, id:\.self) { company in
                                    Text(company.rawValue)
                                }
                            }
                            
                            TextField("운송장 번호", text: $trackingNumber)
                            
                            Button {
                                isShowingTrackingNumberAlert = true
                            } label: {
                                Text("완료")
                            }
                            .alert(isPresented: $isShowingTrackingNumberAlert, content: {
                                if trackingNumber.isEmpty {
                                    return Alert(title: Text("운송장 번호를 입력해주세요"))
                                }
                                else {
                                    let firstButton = Alert.Button.default(Text("네")) {
                                        order.state = OrderStatus.shipment.rawValue
                                        order.deliveryServiceCompany = selectedDelivery.rawValue
                                        order.trackingNumber = trackingNumber
                                        orderStore.editOrder(order: order, orderStatus: .shipment)
                                    }
                                    return Alert(title: Text("운송장 번호 입력을 완료하시겠습니까?"), message: Text("\(selectedDelivery.rawValue) \(trackingNumber)"), primaryButton: firstButton , secondaryButton: .cancel(Text("아니오")))
                                }
                            })
                            
                        }
                        else {
                            Button {
                                isShowingTrackingNumberView.toggle()
                            } label: {
                                Text("운송장 번호 입력")
                            }
                            .foregroundColor(.blue)
                        }
                        
                        cancleButton
                        
                    case OrderStatus.shipment.rawValue:
                        
                        HStack {
                            Text("운송장번호")
                            Spacer()
                            Text(order.deliveryServiceCompany ?? "")
                            Text(order.trackingNumber ?? "")
                        }
                        
                    case OrderStatus.complete.rawValue:
                        Text("확정")
                    default:
                        Text("주문 상세 정보 없음")
                    }
                }
                .onAppear {
                    paymentStore.fetchAPayment(paymentId: order.paymentId)
                }
                
                Section("주문 정보") {
                    HStack {
                        Text("품목명")
                        Spacer()
                        KFImage(URL(string: order.imageURLString)!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .aspectRatio(0.7, contentMode: .fit)
                        
                        Text(order.productName)
                    }
                    
                    HStack {
                        Text("결제 가격")
                        Spacer()
                        Text("\(order.price)원")
                    }
                }
            }
        }
    }
}

