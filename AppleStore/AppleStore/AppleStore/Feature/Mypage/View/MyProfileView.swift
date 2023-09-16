//
//  MyProfileView.swift
//  AppleStore
//
//  Created by dayexx on 2023/09/05.
//

import SwiftUI


struct MyProfileView: View {
    var myInfo: User
    
    var body: some View {
        //User 이미지 추가 등 처리 안함
        HStack{
            Image(systemName: "apple.logo")
                .font(.system(size: 30))
                .foregroundColor(.gray)
                .padding()
            //CircleImageView(image: "").frame(width:50).padding()
            VStack(alignment: .leading) {
                Text(myInfo.userName)
                Text(myInfo.email)
                    .foregroundColor(.blue)
            }
        }
    }
}
