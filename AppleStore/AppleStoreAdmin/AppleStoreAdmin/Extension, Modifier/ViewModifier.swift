//
//  ViewModifier.swift
//  AppleStoreAdmin
//
//  Created by woojin Shin on 2023/09/07.
//

import SwiftUI


struct registButtonDesign: ViewModifier {
    let fillColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .fill(fillColor)
            }
            .foregroundColor(.white)
            .frame(height: 30)
//            .background(.quaternary, in: Capsule())
    }
}



//struct AuroraView: View {
//    @Binding var isPresent: Bool
//    var body: some View {
//        ZStack {
//            // 오로라 효과를 만듭니다.
//            LinearGradient(
//                gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .red]),
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//            )
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .animation(Animation.linear(duration: 2.0)
//                .repeatForever(autoreverses: false), value: isPresent)
//           
//        }
//    }
//}


//struct CustomTransition: AnimatableModifier {
//    var animatableData: Double {
//        get { rotation }
//        set { rotation = newValue }
//    }
//
//    @Binding var isPresenting: Bool
//    var rotation: Double = 0
//
//    func body(content: Content) -> some View {
//        content
//            .rotationEffect(.degrees(isPresenting ? 0 : -90))
//            .scaleEffect(isPresenting ? 1 : 0.5)
//            .opacity(isPresenting ? 1 : 0)
//            .offset(x: isPresenting ? 0 : -100, y: 0)
//    }
//}
//
//extension AnyTransition {
//    static var customTransition: AnyTransition {
//        .modifier(
//            active: CustomTransition(isPresenting: .constant(true)),
//            identity: CustomTransition(isPresenting: .constant(false))
//        )
//    }
//}
