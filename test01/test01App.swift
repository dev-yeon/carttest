//
//  test01App.swift
//  test01
//
//  Created by yeon on 2023/09/05.
//

import SwiftUI

@main
struct test01App: App {
    var body: some Scene {
        WindowGroup {
            CartView()
                .environmentObject(CartViewModel())
                .environmentObject(WishListViewModel()) 
        }
    }
}
