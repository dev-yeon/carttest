////
////  WishListRowView.swift
////  AppleStore
////
////  Created by yeon on 2023/09/07.
////
//
//import SwiftUI
//// MARK: - WishListItemRow
//        struct WishListItemRow: View {
//            let wishListItem: WishListItem
//
//            @EnvironmentObject var wishListViewModel: WishListViewModel
//
//            var body: some View {
//                NavigationStack{
//                    List{
//                        HStack {
//                            Text(wishListItem.name)
//                            Spacer()
//                            Text("\(wishListItem.price)원")
//                        }
//                        .onTapGesture {
//                            wishListViewModel.updateIsAddedStatus(id: wishListItem.id, isAdded: wishListItem.isAdded)
//                        }
//                    }
//                }
//            }
//        }
//
//
//struct WishListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        let sampleWishListItem = WishListItem(id: UUID(), name: "String", price: 0, isAdded: true)
//
//        WishListItemRow(wishListItem: sampleWishListItem)
//            .environmentObject(CartViewModel())
//            .environmentObject(WishListViewModel())
//    }
//}
