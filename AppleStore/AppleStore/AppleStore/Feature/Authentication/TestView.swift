//
//  LoginView.swift
//  AppleStore
//
//  Created by 윤해수 on 2023/09/06.
//

import SwiftUI
import Firebase

struct TestView: View {
    
    @ObservedObject var userService = UserService.shared
    
    var body: some View {
        VStack {
            if let currentUser = userService.currentUser {
                VStack {
                    Text("현재 사용자: \(currentUser.userName)")
                    Text("현재 사용자 UID: \(currentUser.uid)")
                    Text("현재 사용자 UID: \(currentUser.email)")
                }
            } else {
                Text("사용자 정보를 가져오는 중...")
            }
            
            Button("사용자 정보 다시 가져오기") {
                // 사용자 정보 다시 가져오는 작업 수행
                Task { try await userService.fetchUser() }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
