//
//  PurchaseiPadView.swift
//  AppleStore
//
//  Created by SIKim on 2023/09/07.
//

import SwiftUI

struct PurchaseiPadView: View {
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
                ProductMainImageView(
                    itemStore: itemStore, seriesName: seriesName
                )
                
                ///만약 아이패드 시리즈 제품 내에 2개로 분류 된다면 그려줘야한다.
                
                if itemStore.productNameSet.count > 1 {
                    ModelPickView(
                        itemStore: itemStore
                    )
                }
                
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
                
                CellularPickView(
                    itemStore: itemStore
                )
                
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

struct PurchaseiPadView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseiPadView(itemStore: ItemStore(), seriesName: "iPad Air")
    }
}
