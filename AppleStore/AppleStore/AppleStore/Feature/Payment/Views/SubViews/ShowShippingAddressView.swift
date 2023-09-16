//
//  ShowShippingAddressView.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/07.
//

import SwiftUI

struct ShowShippingAddressView: View {
    @StateObject private var myInfoStore: MyInfoStore = MyInfoStore()
    @State var address: String = UserService.shared.currentUser?.headAddress ?? "서울 종로구 종로3길 17"
    @State var postal: String = UserService.shared.currentUser?.postal ?? "12345"
    @State var isShowingAddressSheet: Bool = false
    
    var getSplitAddress: [String] {
        var splitAddress = address.components(separatedBy: " ")
        return splitAddress
    }
    
    var body: some View {
        Grid {
            GridRow(alignment: .top) {
                Text("배송 주소")
                    .frame(width: 80, alignment: .leading)

                HStack {
                    VStack(alignment: .leading) {
                        ForEach(getSplitAddress, id: \.self) { address in
                            Text("\(address)")
                        }
                    }
                    
                    Spacer()
                    Text(">")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 8)
                .onTapGesture {
                    isShowingAddressSheet = true
                }
            }
            .padding(.vertical, 8)
            .sheet(isPresented: $isShowingAddressSheet) {
                NavigationStack{
                    AddressSettingView(myInfoStore: myInfoStore, isShowingAddressSheet: $isShowingAddressSheet)
                }
            }
        }
        .onAppear {
            address = UserService.shared.currentUser?.headAddress ?? "서울 종로구 종로3길 17"
            postal = UserService.shared.currentUser?.postal ?? "12345"
        }
    }
}

struct ShowShippingAddressView_Previews: PreviewProvider {
    static var previews: some View {
        ShowShippingAddressView()
    }
}
