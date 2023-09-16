//
//  View+.swift
//  AppleStoreAdmin
//
//  Created by woojin Shin on 2023/09/05.
//

import SwiftUI


extension View {
    func convertAnyView() -> AnyView {
        return AnyView(self)
    }
    
    ///다른 부분 터치시 키보드 숨기기
    func hideKeyboardOnTap() -> some View {
        self.modifier(HideKeyboardOnTap())
    }
    
}


extension View {
  func toastView(toast: Binding<Toast?>) -> some View {
    self.modifier(ToastModifier(toast: toast))
  }
}



//다른 부분 터치시 키보드 숨기기
struct HideKeyboardOnTap: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil,
                    from: nil,
                    for: nil
                )
            }
    }
}
