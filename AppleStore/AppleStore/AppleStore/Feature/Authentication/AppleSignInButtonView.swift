//
//  AppleSignInView.swift
//  AppleStore
//
//  Created by 윤해수 on 2023/09/12.
//

import SwiftUI
import AuthenticationServices

struct AppleSignInButtonView : View {
    
    @Binding var signInCheck: Bool
    @Binding var alertMessgae: String
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        // 애플 로그인 요청
        SignInWithAppleButton { request in
            startSignInWithAppleFlow()
            // 애플 로그인 요청 이후 결과 값
        } onCompletion: { result in
            switch result {
                // 요청 값 성공 시
            case .success(let user):
                print("success")
                guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                    print("error with firebase")
                    return
                }
                
                let viewModel = AppleSignInService()
                //                viewModel.nonce = self.nonce
                viewModel.authenticate(credential: credential)
                signInCheck = true
                alertMessgae = "Apple로 로그인에 성공했습니다."
                dismiss()
                
                // 요청 값 실패 시
            case .failure(let error):
                print("요청 실패: \(error.localizedDescription)")
            }
        }
        .frame(width : UIScreen.main.bounds.width * 0.9, height:50)
        .cornerRadius(5)
    }
}

struct AppleSignInView_Previews: PreviewProvider {
    static var previews: some View {
        AppleSignInButtonView(signInCheck: .constant(false), alertMessgae: .constant("Ok"))
    }
}
