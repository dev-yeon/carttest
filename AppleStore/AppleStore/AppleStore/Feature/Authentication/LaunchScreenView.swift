//
//  LaunchScreenView.swift
//  AppleStore
//
//  Created by 윤해수 on 2023/09/05.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var isImageVisible = false
    @State private var isTextVisible = false

    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)

            if isImageVisible {
                Text("Hello, SwiftUI!")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .opacity(isTextVisible ? 1.0 : 0) // 텍스트의 투명도를 조절하여 나타나게 함
                    .offset(y: isTextVisible ? 0 : 100) // 텍스트가 아래서 위로 올라오는 애니메이션
//                    .onAppear {
//                        withAnimation(.easeIn(duration: 3.0)) {
//                        }
//                    }
            }

            Image(systemName: "apple.logo")
                .font(.system(size: 100))
                .foregroundColor(.white)
                .offset(y: isImageVisible ? -150 : 0) // 이미지가 위로 올라가는 애니메이션
                .onAppear {
                    // 이미지의 애니메이션이 시작되는 시점에서 이미지를 보이도록 토글
                    withAnimation(.easeInOut(duration: 1.0)) {
                        isImageVisible.toggle()
                    }
                    
                    // 텍스트 애니메이션 시작
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            isTextVisible.toggle()
                        }
                    }
                }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
