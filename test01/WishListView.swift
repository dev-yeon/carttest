//
//  WishListView.swift
//  test01
//
//  Created by yeon on 2023/09/06.
//

import SwiftUI

// MARK: 위시리스트 뷰
struct WishListView: View {
    @EnvironmentObject var wishListViewModel: WishListViewModel
    @State private var isDetailVisible: Bool = false  // 세부정보 표시 여부를 결정하는 State 변수
    var body: some View {
        NavigationStack{
            List {
                
                ForEach(wishListViewModel.wishListItems) { item in
                    
                    VStack{
                        HStack {
                            Image(systemName: "applelogo")
                                .font(.system(size: 50))
                            
                            VStack{
                                HStack{
                                    Text(item.name)
                                    Spacer()
                                    Text("₩\(item.price)")
                                
                                    Spacer()
                                }.fontWeight(.semibold)
                                HStack{
                                    VStack{
                                        Spacer()
                                        Button("세부정보 보기") {
                                            isDetailVisible.toggle()
                                        }
                                        .font(.caption)
                                        .foregroundColor(.cyan)
                                        
                                    }
                                    Spacer()
                                }
                            }
                            
                            if item.isAdded {
                                Image(systemName: "checkmark")
                            }
                        }
                        
                        if isDetailVisible {
                            
                            VStack{
                                HStack{
                                    Text("도착:")
                                    Spacer()
                                }
                                HStack{
                                    Text("재고가 있으며, 배송 준비가 끝났습니다.")
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                                HStack{
                                    Text("지금 주문하기. 매장 내 픽업:")
                                    Spacer()
                                }
                                HStack{
                                    Text("오늘, 위치: Apple 강남")
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                                Spacer()
                                
                            }
                            .font(.caption)
                            Text("세부정보: \(item.name)")
                        }
                    }
                    
//                    .onTapGesture {
//                        wishListViewModel.updateIsAddedStatus(id: item.id, isAdded: !item.isAdded)
//                    }
                }
                .onDelete(perform: wishListViewModel.deleteItems)
            }
            
            .navigationBarTitle("모든 관심 제품", displayMode: .large)
            
            
        }
        
    }
}
// MARK: - WishListItemRow
struct WishListItemRow: View {
    let wishListItem: WishListItem
    @EnvironmentObject var wishListViewModel: WishListViewModel
    
    var body: some View {
        NavigationStack{
            List{
                HStack {
                    Text(wishListItem.name)
                    Spacer()
                    Text("\(wishListItem.price)원")
                    NavigationLink(destination: PaymentView()) { // 결제하기 페이지로 이동
                        Text("결제하기")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 44) // 높이 설정
                            .foregroundColor(.white) // 텍스트를 흰색으로
                            .background(Color.blue) // 배경을 파란색으로
                            .cornerRadius(10) // 모서리를 둥글게
                        
                    }
                    
                }
                .onTapGesture {
                    wishListViewModel.updateIsAddedStatus(id: wishListItem.id, isAdded: wishListItem.isAdded)
                }
            }
            
        }
    }
}
struct WishListView_Previews: PreviewProvider {
    static var previews: some View {
        WishListView()
            .environmentObject(CartViewModel())
            .environmentObject(WishListViewModel())
        
    }
}
