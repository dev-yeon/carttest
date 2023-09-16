//
//  AppleStoreTabView.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/07.
//

import SwiftUI

struct CurrentTabKey: EnvironmentKey {
    static var defaultValue: Binding<Int> = .constant(0)
}

extension EnvironmentValues {
    var currentTab: Binding<Int> {
        get { self[CurrentTabKey.self] }
        set { self[CurrentTabKey.self] = newValue }
    }
}

struct AppleStoreTabView: View {
    @AppStorage("selectedTab") private var selectedTab: Int = 0
    @StateObject var cartItemStore: CartItemStore = CartItemStore()
    @StateObject var orderStore: OrderStore = OrderStore()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "macbook.and.iphone")
                    Text("쇼핑하기")
                }
                .onAppear { selectedTab = 0}
                .tag(0)
            NavigationStack {
                MapView()
            }
                .tabItem {
                    Image(systemName: "map")
                    Text("지도")
                }
                .onAppear { selectedTab = 1}
                .tag(1)
            SearchMainView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("검색")
                }
                .onAppear { selectedTab = 2 }
                .tag(2)
            CartView()
                .tabItem {
                    Image(systemName: "bag")
                    Text("장바구니")
                }
                .onAppear { selectedTab = 3 }
                .tag(3)
            //TODO: 마이페이지
                MyPageMainView()
                .tabItem {
                    Image(systemName: "person")
                    Text("마이페이지")
                }
                .onAppear { selectedTab = 4 }
                .tag(4)
        }.onAppear{
            Task{
                try await UserService.shared.fetchUser()
            }
        }
        .environmentObject(cartItemStore)
        .environmentObject(orderStore)
        .environment(\.currentTab, $selectedTab)
    }
}

struct AppleStoreTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppleStoreTabView()
    }
}
