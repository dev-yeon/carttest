//
//  CartView.swift
//  test01
//
//  Created by yeon on 2023/09/06.

import SwiftUI

//MARK: CartItem
struct CartItem: Identifiable {
    let id: UUID
    let name: String
    let price: Int
    var amount: Int
    var isChecked: Bool
}
//MARK: CartViewModel
class CartViewModel: ObservableObject {
    @Published var isEditing: Bool = false
    
    @Published var cartItems: [CartItem] = []
    @Published var isAllItemsChecked: Bool = false {
        didSet {
            cartItems = cartItems.map {
                var mutableItem = $0
                mutableItem.isChecked = isAllItemsChecked
                return mutableItem
            }
        }
    }
    
    var totalPrice: Int {
        return cartItems.reduce(0) { $0 + ($1.isChecked ? $1.price * $1.amount : 0) }
    }
    
    init() {
        let item1 = CartItem(id: UUID(), name: "MacBook Pro", price: 2000000, amount: 1, isChecked: false)
        let item2 = CartItem(id: UUID(), name: "iPhone", price: 1000000, amount: 1, isChecked: false)
        cartItems = [item1, item2]
    }
    
    func updateAmount(id: UUID, amount: Int) {
        if let index = cartItems.firstIndex(where: { $0.id == id }) {
            var item = cartItems[index]
            item.amount = amount
            cartItems[index] = item
        }
    }
    
    func updateCheckedStatus(id: UUID, isChecked: Bool) {
        if let index = cartItems.firstIndex(where: { $0.id == id }) {
            var item = cartItems[index]
            item.isChecked = isChecked
            cartItems[index] = item
        }
    }
    
    func clearSelectedCart() {
        cartItems.removeAll { $0.isChecked }
    }
    
    func deleteItems(at offsets: IndexSet) {
        cartItems.remove(atOffsets: offsets)
    }
    
    func moveItems(from source: IndexSet, to destination: Int) {
        cartItems.move(fromOffsets: source, toOffset: destination)
    }
    
    func toggleEditMode() {
        isEditing.toggle()
    }
    
    // 타입변환으로 카트아이템을 위시아이템으로 만들어주었다 .
    func convertToWishListItem(cartItem: CartItem) -> WishListItem {
        return WishListItem(id: cartItem.id, name: cartItem.name, price: cartItem.price, isAdded: false)
    }
    
}

//MARK: cartView
struct CartView: View {
    @State private var actionTitle = ""
    @EnvironmentObject var cartViewModel: CartViewModel
    @EnvironmentObject var wishListViewModel: WishListViewModel
    @State private var isEditing = false // 편집 모드 상태를 추적하는 변수
    
    var body: some View {
        NavigationView {
            List {
                
                ForEach(cartViewModel.cartItems) { item in
                    CartItemRow(cartItem: item)
                        .environmentObject(cartViewModel)
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        }
                        .swipeActions(edge: .trailing) {
                            if isEditing  {  // 편집 모드일 때만 표시
                                Button(role: .destructive) {
                                    actionTitle = "Move the trash"
                                } label: {
                                    Label("선택 삭제", systemImage: "trash.circle")
                                }
                                .tint(.red)
                                
                                Button(action: {
                                    let wishListItem = cartViewModel.convertToWishListItem(cartItem: item)
                                    wishListViewModel.addToWishList(item: wishListItem)
                                    actionTitle = "\(item.name)을(를) 찜 목록에 추가했습니다."
                                }) {
                                    Label("저장", systemImage: "star.circle")
                                }
                                .tint(Color.indigo)
                            }
                        }
                }
                .onDelete(perform: cartViewModel.isEditing ? cartViewModel.deleteItems : nil)
                // 이 부분이 중요
                
                Toggle("전체 선택", isOn: $cartViewModel.isAllItemsChecked)
                VStack{
                    HStack{
                        Text("장바구니 소계")
                        Spacer()
                        Text("₩\(cartViewModel.totalPrice)")
                    }
                    HStack{
                        Text("다음 부가가치세 포함")
                        Spacer()
                        Text("₩\(Int(Double(cartViewModel.totalPrice)/0.11))")
                    }
                    .font(.caption2)
                    .foregroundColor(.gray)
                }
                //MARK: 위시리스트
                Section(
                    header:
                        HStack {
                            Text("찜 목록")
                                .font(.headline)
                            Spacer()
                            NavigationLink(destination: WishListView()) {
                                Text("모두 보기")
                            }
                        }
                ) {
                    ForEach(wishListViewModel.wishListItems) { item in
                        WishListItemRow(wishListItem: item)
                    }
                }
        
            }
            .environmentObject(cartViewModel)
            
            
            .navigationBarTitle("장바구니", displayMode: .automatic)
            .navigationBarItems(leading: Button(action: {
                isEditing.toggle() // 편집 모드 상태를 토글
                cartViewModel.clearSelectedCart()
            })
                                
                                {
                VStack {
                    Image(systemName: "gearshape.fill")
                    Text(isEditing ? "확인" : "편집")  // 편집 모드 상태에 따라 텍스트 변경
                    
                    // 글자 크기를 작게 설정
                }
                .foregroundColor(.blue)
            })
            
            .navigationBarItems(trailing: Button(action: {
                //  cartViewModel.clearSelectedCart()
                let selectedItems = cartViewModel.cartItems.filter { $0.isChecked }
            }) {
                VStack {
                    
                    //Text("결제하기")
                    // 글자 크기를 작게 설정
                    NavigationLink(destination: PaymentView()) { // 결제하기 페이지로 이동
                        Text("결제하기")
                            .frame(minWidth: 0, maxWidth: .infinity) // 버튼을 확장
                            .frame(height: 45) // 높이 설정
                            .frame(width: 70)
                            .foregroundColor(.white) // 텍스트를 흰색으로
                            .background(Color.blue) // 배경을 파란색으로
                            .cornerRadius(10) // 모서리를 둥글게
                    }
                }
                .foregroundColor(.blue)
            })
        }
        
    }
    
    //MARK: CartItemRow
    struct CartItemRow: View {
        let cartItem: CartItem
        @EnvironmentObject var cartViewModel: CartViewModel
        @EnvironmentObject var wishListViewModel: WishListViewModel
        
        var body: some View {
            VStack{
                
                HStack {
                    Button(action: {
                        cartViewModel.updateCheckedStatus(id: cartItem.id, isChecked: !cartItem.isChecked)
                    }) {
                        Image(systemName: cartItem.isChecked ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(cartItem.isChecked ? Color.blue : Color.gray)
                    }
                    //Spacer()
                    VStack{
                        HStack{
                            Text(cartItem.name)
                            
                            Spacer()
                            Text("₩\(cartItem.price * cartItem.amount)")
                        }
                        .font(.title3)
                        HStack{
                            Text("수량")
                                .font(.caption2)
                            Stepper("\(cartItem.amount)",
                                    
                                    value: Binding(
                                        get: { cartItem.amount },
                                        set: { cartViewModel.updateAmount(id: cartItem.id, amount: $0) }
                                    ), in: 0...100)
                        }
                        VStack{
                            HStack{

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
                                    HStack{
                                        Button(action: {
                                            let wishListItem = cartViewModel.convertToWishListItem(cartItem: cartItem)
                                            wishListViewModel.addToWishList(item: wishListItem)
                                        }) {
                                            Text("나중을 위해 저장")
                                                .font(.caption)
                                                .foregroundColor(.blue)
                                        }
                                        Spacer()
                                    }
                                }
                                .font(.caption)
                            }
                        }
                    }
                }
            }
        }
    }
    //MARK: cartView_Previews
    struct cartView_Previews: PreviewProvider {
        static var previews: some View {
            CartView()
                .environmentObject(CartViewModel())
                .environmentObject(WishListViewModel())
        }
    }
}
