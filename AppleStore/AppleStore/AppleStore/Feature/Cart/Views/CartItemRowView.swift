////
////  CartItemRowView.swift
////  AppleStore
////
////  Created by yeon on 2023/09/07.
////
//
//import SwiftUI
//
////MARK: CartItemRow
//struct CartItemRow: View {
//    let cartItem: CartItem
//
//    @Environment(\.isEditing) var isEditing: Bool
//    @EnvironmentObject var cartViewModel: CartViewModel
//    @EnvironmentObject var wishListViewModel: WishListViewModel
//
//    var body: some View {
//
//        VStack{
//
//            HStack {
//                HStack{
//                    Image(systemName: "apple.logo")
//                        .font(.largeTitle)
//
//                }
//                //MARK:  선택 체크 동그라미 버튼 (편집 모드일 때만 보임)
//                if isEditing {
//                    Button(action: {
//                        cartViewModel.updateCheckedStatus(id: cartItem.id, isChecked: !cartItem.isChecked)
//                    }) {
//                        Image(systemName: cartItem.isChecked ? "checkmark.circle.fill" : "circle")
//                            .foregroundColor(cartItem.isChecked ? Color.blue : Color.gray)
//                    }
//                }
//                VStack{
//                    Divider()
//                    HStack{
//                        Text(cartItem.name)
//
//                        Spacer()
//                        Text("₩\(cartItem.price * cartItem.amount)")
//                    }
//                    .font(.title3)
//                    HStack{
//                        Text("수량")
//                            .font(.caption2)
//                        //MARK: 수량 변경 Stepper (편집 모드일 때만 보임)
//                        if isEditing {
//                            Stepper("\(cartItem.amount)",
//                                    value: Binding(
//                                        get: { cartItem.amount },
//                                        set: { cartViewModel.updateAmount(id: cartItem.id, amount: $0) }
//                                    ), in: 1...100)
//                        } else {
//                            Text("\(cartItem.amount)")
//                        }
//                    }
//                    VStack{
//                        HStack{
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
//                                //Divider()
//                                HStack{
//                                    Button(action: {
//                                        let wishListItem = cartViewModel.convertToWishListItem(cartItem: cartItem)
//                                        wishListViewModel.addToWishList(item: wishListItem)
//                                    }) {
//                                        Text("나중을 위해 저장")
//                                            .font(.caption)
//                                            .foregroundColor(.blue)
//                                    }
//                                    Spacer()
//                                }
//                            }
//                            .font(.caption)
//                        }
//                    }
//                }
//            }
//        }
//
//    }
//}
//
//struct CartItemRowView_Previews: PreviewProvider {
//
//
//    static var previews: some View {
//        //CartItemRowView()
//        let sampleCartItem = CartItem(id: UUID(), name: "iPad", price:200000, amount: 1, isChecked: false)
//        CartItemRow(cartItem: sampleCartItem)
//            .environmentObject(CartViewModel())
//            .environmentObject(WishListViewModel())
//    }
//}
