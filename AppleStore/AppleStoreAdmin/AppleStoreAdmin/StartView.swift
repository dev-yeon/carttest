//
//  ContentView.swift
//  AppleStoreAdmin
//
//  Created by cha_nyeong on 2023/09/05.
//

import SwiftUI

struct StartView: View {
    @State private var isLogin: Bool = true
    
    var body: some View {
        if isLogin {
            MainView()
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
