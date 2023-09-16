//
//  WishListViewModel.swift
//  test01
//
//  Created by yeon on 2023/09/06.
//
import Foundation
// WishListItem 구조체 정의
struct WishListItem: Identifiable {
    let id: UUID
    let name: String
    let price: Int
    var isAdded: Bool // 상품이 카트에 추가되었는지 여부
}
class WishListViewModel: ObservableObject {
    @Published var wishListItems: [WishListItem] = []
    
    // 초기 데이터 설정

    init() {
       let item1 = WishListItem(id: UUID(), name: "MacBook Pro", price: 2000000, isAdded: true)
        let item2 = WishListItem(id: UUID(), name: "iPhone", price: 1000000, isAdded: true)
       wishListItems = [item1, item2]
    }
 
    
    
    func addToWishList(item: WishListItem) {
        wishListItems.append(item)
    }
    // 상품의 추가 상태(isAdded) 업데이트
    func updateIsAddedStatus(id: UUID, isAdded: Bool) {
        if let index = wishListItems.firstIndex(where: { $0.id == id }) {
            var item = wishListItems[index]
            item.isAdded = isAdded
            wishListItems[index] = item
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        wishListItems.remove(atOffsets: offsets)
    }
    
    func deleteAllItems() {
        wishListItems.removeAll()
    }
    
    
    
}
