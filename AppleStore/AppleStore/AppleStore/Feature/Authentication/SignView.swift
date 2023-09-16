//
//  SignView.swift
//  AppleStore
//
//  Created by 윤해수 on 2023/09/05.
//

import SwiftUI
import AuthenticationServices

struct SignView: View {
    @Binding var path: [String]
    
    var myInfoStore : MyInfoStore
    
    @State private var userID: String = ""
    @State private var userPW: String = ""
    
    // 비밀번호 시각화
    @State private var showUserPW: Bool = false
    
    // 계정 정보 확인 후 Alert 출력
    @State private var signInCheck: Bool = false
    @State private var alertMessgae: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Image(systemName: "apple.logo")
                .font(Font.system(size: 100))
                .padding(.bottom)
            
            VStack {
                TextField("아이디를 입력하세요.", text: $userID)
                    .modifier(SignViewTextFieldModifier())
                    .modifier(SignViewModifier())
                
                // 비밀번호 입력 및 보기 토글
                HStack {
                    if showUserPW {
                        TextField("비밀번호를 입력하세요.", text: $userPW)
                            .modifier(SignViewTextFieldModifier())
                        
                        Button(action: {
                            self.showUserPW.toggle()
                        }, label: {
                            Image(systemName: "eye")
                                .foregroundColor(.secondary)
                        })
                    } else {
                        SecureField("비밀번호를 입력하세요.", text: $userPW)
                            .modifier(SignViewTextFieldModifier())
                        
                        Button(action: {
                            self.showUserPW.toggle()
                        }, label: {
                            Image(systemName: "eye.slash")
                                .foregroundColor(.secondary)
                        })
                    }
                }
                .modifier(SignViewModifier())
                
                // SignIn 버튼 부분
                HStack {
                    Spacer()
                    
                    Button("로그인") {
                        Task {
                            let signInResult: (result: Bool, message: String) = try await AuthService.shared.signIn(withEmail: userID, password: userPW)
                            signInCheck = signInResult.result
                            alertMessgae = signInResult.message
                            print(signInCheck)
                            
                            if !signInCheck {
                                Task{
                                    try await myInfoStore.fetchMyInfo()
                                }
                                dismiss()
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(5)
            }
            .padding()
            
//            AppleSignInButtonView(signInCheck: $signInCheck, alertMessgae: $alertMessgae)
//                .padding()
            
            HStack {
                Text("계정이 없으신가요?")
                
                Button {
                    path.append("SignUpView")
                } label: {
                    Text("회원가입")
                }
            }
            .padding(.bottom)
        }
        .alert(alertMessgae,
               isPresented: $signInCheck) {
            Button("OK") {}
        }
    }
}

struct SignView_Previews: PreviewProvider {
    static var previews: some View {
        SignView(path: .constant([]), myInfoStore: MyInfoStore())
    }
}
