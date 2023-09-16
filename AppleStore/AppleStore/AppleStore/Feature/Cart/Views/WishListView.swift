////
////  WishListView.swift
////  test01
////
////  Created by yeon on 2023/09/06.
////
//
//import SwiftUI
//
//// MARK: 위시리스트 뷰
//struct WishListView: View {
//    @EnvironmentObject var wishListViewModel: WishListViewModel
////    @EnvironmentObject var cartViewModel: CartViewModel
//    @State private var isDetailVisible: Bool = false  // 세부정보 표시 여부를 결정하는 State 변수
//    @State private var showAlert: Bool = false  // 전체 삭제 알림
//
//    var body: some View {
//        NavigationStack{
//            List {
//                ForEach(wishListViewModel.wishListItems) { item in
//                    VStack{
//                        HStack {
//                            Image(systemName: "applelogo")
//
//                            VStack{
//                                HStack{
//                                    Text(item.name)
//                                    Spacer()
//                                    Text("₩\(item.price)")
//                                    Spacer()
//                                }
//                                HStack{
//                                    VStack{
//                                        Spacer()
//                                        Button("세부정보 보기") {
//                                            isDetailVisible.toggle()
//                                        }
//                                        .font(.caption)
//                                        .foregroundColor(.cyan)
//
//                                    }
//                                    Spacer()
//                                }
//                            }
//                            if item.isAdded {
//                                Image(systemName: "checkmark")
//                            }
//                        }
//
//                        if isDetailVisible {
//
//                            VStack{
//                                HStack{
//                                    Text("도착:")
//                                    Spacer()
//                                }
//                                HStack{
//                                    Text("재고가 있으며, 배송 준비가 끝났습니다.")
//                                        .foregroundColor(.gray)
//                                    Spacer()
//                                }
//                                HStack{
//                                    Text("지금 주문하기. 매장 내 픽업:")
//                                    Spacer()
//                                }
//                                HStack{
//                                    Text("오늘, 위치: Apple 강남")
//                                        .foregroundColor(.gray)
//                                    Spacer()
//                                }
//                                Spacer()
//
//                            }
//                            .font(.caption)
//                            Text("세부정보: \(item.name)")
//                        }
//                    }
//                    .onTapGesture {
//                        wishListViewModel.updateIsAddedStatus(id: item.id, isAdded: !item.isAdded)
//                    }
//                }
//                .onDelete(perform: wishListViewModel.deleteItems)
//            }
//            .navigationBarTitle("위시리스트", displayMode: .inline)
//            .navigationBarItems(trailing: Button("전체 삭제") {
//                if !wishListViewModel.wishListItems.isEmpty {
//                    wishListViewModel.deleteAllItems()
//                    showAlert = true
//                }
//            })
//            .alert(isPresented: $showAlert) {
//                Alert(title: Text("알림"), message: Text("모든 항목이 삭제되었습니다."), dismissButton: .default(Text("확인")))
//            }
//        }
//    }
//    /*
//    // MARK: - WishListItemRow
//    struct WishListItemRow: View {
//        let wishListItem: WishListItem
//
//        @EnvironmentObject var wishListViewModel: WishListViewModel
//
//        var body: some View {
//            NavigationStack{
//                List{
//                    HStack {
//                        Text(wishListItem.name)
//                        Spacer()
//                        Text("\(wishListItem.price)원")
//                    }
//                    .onTapGesture {
//                        wishListViewModel.updateIsAddedStatus(id: wishListItem.id, isAdded: wishListItem.isAdded)
//                    }
//                }
//            }
//        }
//    }
//     */
//
//    struct WishListView_Previews: PreviewProvider {
//        static var previews: some View {
//            WishListView()
//                .environmentObject(CartViewModel())
//                .environmentObject(WishListViewModel())
//
//        }
//    }
//
//}
