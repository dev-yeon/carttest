//
//  SignViewModifier.swift
//  AppleStore
//
//  Created by 윤해수 on 2023/09/07.
//

import SwiftUI

/// 로그인뷰 디자인
struct SignViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 0.5))
    }
}

/// 로그인뷰 TextField 기본 디자인
struct SignViewTextFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .autocapitalization(.none)
            .textInputAutocapitalization(.none)
    }
}

/// 로그인뷰 경고 메세지 디자인
struct SignViewTextAlertModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.red)
            .font(.caption)
    }
}
