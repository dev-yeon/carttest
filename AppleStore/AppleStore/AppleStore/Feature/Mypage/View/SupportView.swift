//
//  HelpView.swift
//  AppleStore
//
//  Created by dayexx on 2023/09/05.
//

import SwiftUI

struct SupportView: View {
    @State var showingAppleWebSheet : Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer(minLength: 10)
                
                /* 애플 홈페이지 */
                SupportCellView(titleText: "가지고 계신 제품에 관한 도움을 받으세요.", image: "applelogo", subTitle: "Apple 지원", explain: "도움말 문서를 읽어보고, 전문가에게 문의하고, Apple 지원을 통해 수리 서비스를 예약하세요.",frameHeight: 100)
                    .onTapGesture{
                        showingAppleWebSheet = true
                    }
                
                Spacer(minLength: 50)
                
                /* 주문 도움 */
                NavigationLink {
                    OrderListView()
                } label: {
                    SupportCellView(titleText: "제품 구입 또는 주문과 관련한 도움을 받으세요.", image: "shippingbox.fill", subTitle: "주문 보기", explain: "계정 탭에서 모든 주문 정보를 확인하세요.",frameHeight: 50)
                }
                
                Spacer(minLength: 250)
                
            }.listStyle(.plain)
                .navigationTitle("도움")
                .sheet(isPresented: $showingAppleWebSheet){
                    SupportSafariView(siteURL: "https://getsupport.apple.com/?caller=asa&locale=ko_KR")
                }
        }
    }
}



/* 전화걸기는 에뮬레이터에서만 작동한다,, */
/*Button("전화 걸기") {
 if let url = URL(string: "tel://1234567890") {
 UIApplication.shared.open(url, options: [:], completionHandler: nil)
 }
 }*/


struct SupportView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SupportView()
        }
    }
}
