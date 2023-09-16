//
//  PurchaseiPhoneView.swift
//  AppleStore
//
//  Created by SIKim on 2023/09/05.
//

import SwiftUI

struct PurchaseiPhoneView: View {
    @ObservedObject var itemStore: ItemStore
    @EnvironmentObject var cartItemStore: CartItemStore
    @Environment(\.currentTab) var tabIndex
    @State private var isShowingShare: Bool = false
    @State private var isShowingBookmark: Bool = false
    var seriesName: String
    
    var body: some View {
        //홈뷰의 네비게이션 스택으로부터 와서 해당 스택 중복으로 인해 삭제
        VStack {
            PriceTopView(itemStore: ItemStore())
            
            ScrollView {
                EventTextView()
                
                ProductMainImageView(
                    itemStore: itemStore, seriesName: seriesName
                )
                
                ModelPickView(itemStore: itemStore)
                
                ColorPickView(
                    itemStore: itemStore
                )
//                    .opacity(isModelPickButtonActive ? 1.0 : 0.5)
//                    .disabled(isModelPickButtonActive ? false : true)
                
                StoragePickView(
                    itemStore: itemStore
                )
//                    .opacity(isColorPickButtonActive ? 1.0 : 0.5)
//                    .disabled(isColorPickButtonActive ? false : true)
                
                ProductContentsView(itemStore: itemStore)
                
                Divider()
                
                DeliveryGuideView()
                
                Button {
                    guard itemStore.selectedItems.count == 1 else { return }
                    cartItemStore.addOneItemToCart(item: itemStore.selectedItems[0])
                    tabIndex.wrappedValue = 3
                } label: {
                    Text("장바구니에 담기")
                        .frame(maxWidth: .greatestFiniteMagnitude)
                }
                .buttonStyle(.borderedProminent)
                .padding()
                .disabled(!(itemStore.selectedItems.count == 1))
                //                DeliveryGuideView() 누락
                //                현시점 추가 완료
            }
        }
        //네비게이션 타이틀만큼 상단에서 자리를 차지함.
        //따라서 인라인 처리
        //메모 해주셨는데 시뮬레이터로 확인해도 이해 못했습니다.
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isShowingShare.toggle()
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "bookmark")
                }
                .disabled(!(itemStore.selectedItems.count == 1))
            }
        }
        .sheet(isPresented: $isShowingShare) {
            Text("공유하기 준비중")
                .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $isShowingBookmark) {
            Text("관심제품 준비중")
                .presentationDetents([.medium, .large])
        }
        .onAppear {
            itemStore.seriesName = seriesName
            itemStore.buttonInitializer()
        }
    }
}

struct PurchaseiPhoneView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PurchaseiPhoneView(itemStore: ItemStore(), seriesName: "iPhone 14 Pro")
        }
    }
}

//struct iPhoneSeries {
//    var seriesNames: String //아이폰 시리즈 이름 예: iPhone 14
//    var productNames: [String]  //아이폰 시리즈 내의 제품들 예: iPhone 14, 14Plus
//    var prices: [String]    //제품들 옵션에 따른 가격들, Int로 쓸지 String으로 쓸지 체크
//    var mainImageStrings: [String]  //구매페이지에서 먼저 보이는 이미지들, 옵션 선택마다 이미지가 바뀌어서 배열로 일단 뒀음
//    var galleryStrings: [String]    //갤러리 버튼 누르면 이미지 여러장나옴
//    var productColors: [String] //시리즈에 따른 색상들
//    var storages: [String]  //저장용량들, Int로 할지 String으로 할지 체크
//    var contentsImageStrings: [String]  //제품구성에 들어갈 이미지들
//}
//
//struct iPad {
//    var productName: String //제품 이름
//    var prices: [String]    //옵션에 따른 가격들, Int로 쓸지 String으로 쓸지 체크
//    var inchModels: [String]    //제품에 따른 인치 옵션들
//    var mainImageStrings: [String]  //구매 페이지에서 먼저 보이는 이미지들, 옵션선택에 따라 이미지가 바뀌어서 배열로 둠
//    var galleryStrings: [String]    //갤러리 버튼 누르면 이미지 여러장나옴
//    var productColors: [String] //제품의 색상들
//    var storages: [String]  //저장용량들, Int로 할지 String으로 할지 체크
//    var EmbedCellular: [String]   //wifi / wifi + cellular
//}



