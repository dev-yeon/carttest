//
//  HomeViewModifier.swift
//  AppleStore
//
//  Created by KangHo Kim on 2023/09/12.
//

import SwiftUI

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height
let tabBarHeight = UITabBarController().height

struct HomeViewSectionHeight: ViewModifier {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    func body(content: Content) -> some View {
        content
            .frame(width: screenWidth
                   ,height: screenHeight - (safeAreaInsets.top + safeAreaInsets.bottom + UITabBarController().height * 2))
            .padding(.top, 24)
    }
}

struct HomeViewSectionTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .fontWeight(.semibold)
            .padding(.bottom, 5)
            .padding(.horizontal)
//            .padding()
//            .background(.quaternary, in: Capsule())

    }
}

extension View {
    func homeViewSectionHeight() -> some View {
        modifier(HomeViewSectionHeight())
    }
    func homeViewSectionTitle() -> some View {
        modifier(HomeViewSectionTitle())
    }
}
