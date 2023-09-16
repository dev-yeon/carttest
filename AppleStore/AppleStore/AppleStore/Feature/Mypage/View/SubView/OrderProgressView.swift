//
//  OrderProgressView.swift
//  AppleStore
//
//  Created by dayexx on 2023/09/07.
//

import SwiftUI

struct OrderProgressView: View {
    var order: Order
    @State private var currentOrderState: OrderState = .ready
  
    let stateList = OrderState.allCases.filter{ $0 != .canceled }
    
    //뷰 거지같이 스페이스 끼워놨습니다 흑흑흑흑흑ㄱ 하지만 귀찮아 ㅋ

    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Spacer()
                VStack(alignment: .leading) {
                    Text(currentOrderState.rawValue).bold().frame(height: 50)
                    Text(currentOrderState.description).font(.footnote)
                }.padding()
                Spacer(minLength: 240)
            }
            
            VStack {
                ProgressView(value: currentOrderState.progress)
                    .frame(width: 310.0, height: 30)
                HStack {
                    Spacer(minLength: 30)
                    ForEach(stateList, id: \.self) { state in
                        Spacer()
                        Text("\(state.rawValue)")
                            .font(.caption)
                            .bold(state == currentOrderState)
                        Spacer()
                    }
                    Spacer(minLength: 30)
                }.frame(width: 400)
            }
           Spacer()
        }.onAppear {
            currentOrderState = OrderState(rawValue: order.state) ?? .ready
        }
    }
}
//얼ㅋ
enum OrderState: String, CaseIterable {
    
    case ready = "입금 대기"
    case completed = "결제 완료"
    case shipping = "상품 준비중"
    case delivered = "상품 발송"
    case confirmed = "구매 확정"
    case canceled = "주문 취소"
    
    var description: String {
        switch self {
        case .ready: return "입금 대기중 결제를 완료하세요!"
        case .completed: return "결제가 완료되었습니다."
        case .shipping: return "상품을 준비중입니다."
        case .delivered: return "상품이 배송되었습니다."
        case .confirmed: return "구매가 확정되었습니다."
        case .canceled: return "주문이 취소되었습니다."
        }
    }
    
    var progress: Float {
        switch self {
        case .ready: return 0.1
        case .completed: return 0.3
        case .shipping: return 0.5
        case .delivered: return 0.7
        case .confirmed: return 1.0
        case .canceled: return 0.0
        }
    }
    
    static let stateList = [ready, completed, shipping, delivered, confirmed]
}
