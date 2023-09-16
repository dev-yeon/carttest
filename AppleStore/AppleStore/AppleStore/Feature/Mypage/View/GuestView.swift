//
//  GuestView.swift
//  AppleStore
//
//  Created by dayexx on 2023/09/07.
//

import SwiftUI

struct GuestView: View {
    //    @Binding var isLogin: Bool
    var myInfoStore : MyInfoStore
    @Binding var path : [String]
    
    var body: some View {
        VStack(alignment:.center) {
            Image(systemName: "apple.logo").font(.system(size: 50))
            
            Text("Apple Store 앱에서 쇼핑하려면 로그인이 필요합니다.")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .padding()
            
            Text("로그인 하려면 아래 버튼으로 로그인하세요.")
                .foregroundColor(.gray)
            
            Button {
                path.append("SignInView")
            } label: {
                ZStack{
                    Rectangle()
                        .frame(width:300, height: 40)
                        .foregroundColor(.blue)
                        .cornerRadius(7)
                    Text("로그인")
                        .bold()
                        .foregroundColor(.white)
                        
                }
                .padding()
            }
        }
        .padding()
        .navigationDestination(for: String.self) { String in
            if String == "SignInView"{
                SignView(path: $path, myInfoStore: myInfoStore)
            }
            else if String == "SignUpView" {
                SignUpView(path: $path, myInfoStore: myInfoStore)
            }
        }
    }
}


struct GuestView_Previews: PreviewProvider {
    static var previews: some View {
        GuestView(myInfoStore: MyInfoStore(), path: .constant([]))
    }
}
