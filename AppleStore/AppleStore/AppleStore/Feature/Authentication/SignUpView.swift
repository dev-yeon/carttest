//
//  SignUpView.swift
//  AppleStore
//
//  Created by 윤해수 on 2023/09/05.
//

import SwiftUI

struct SignUpView: View {
    @Binding var path: [String]
    var myInfoStore : MyInfoStore
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var passwordRepeat: String = ""
    @State private var userName: String = ""
    
    // 비밀번호 시각화
    @State private var passwordShow: Bool = false
    @State private var passwordRepeatShow: Bool = false
    
    // 아이디 중복 여부 & 비밀번호 재확인 여부 확인
    @State private var idCheck: Bool = false
    @State private var passwordCheck: Bool = false
    
    @State private var showAlert: Bool = false
    @State private var showAlertMessage: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            // MARK: - 회원가입 아이디 입력
            TextField("아이디를 입력하세요.", text: $id)
                .modifier(SignViewTextFieldModifier())
                .modifier(SignViewModifier())
                .onChange(of: id) { userWriteID in
                    // 이메일 입력이 변경될 때마다 유효성을 검사
                    AuthService.shared.checkUserID(withEmail: userWriteID) { CheckedID in
                        if CheckedID {
                            idCheck = true
                        } else {
                            idCheck = false
                        }
                    }
                }
            
            if idCheck {
                Text("이미 존재하는 아이디입니다")
                    .modifier(SignViewTextAlertModifier())
            }
            
            // MARK: - 회원가입 비밀번호 입력 및 처리
            // 토글 값에 따라 비밀번호 시각적 처리
            VStack(alignment: .leading) {
                HStack {
                    if passwordShow {
                        TextField("비밀번호를 입력하세요.", text: $password)
                            .modifier(SignViewTextFieldModifier())
                        
                        Button(action: {
                            self.passwordShow.toggle()
                        }, label: {
                            Image(systemName: "eye")
                                .foregroundColor(.secondary)
                        })
                    } else {
                        SecureField("비밀번호를 입력하세요.", text: $password)
                            .modifier(SignViewTextFieldModifier())
                        
                        Button(action: {
                            self.passwordShow.toggle()
                        }, label: {
                            Image(systemName: "eye.slash")
                                .foregroundColor(.secondary)
                        })
                    }
                }
                .modifier(SignViewModifier())
                
                HStack {
                    if passwordRepeatShow {
                        TextField("비밀번호를 입력하세요.", text: $passwordRepeat)
                            .modifier(SignViewTextFieldModifier())
                        
                        Button(action: {
                            self.passwordRepeatShow.toggle()
                        }, label: {
                            Image(systemName: "eye")
                                .foregroundColor(.secondary)
                        })
                    } else {
                        SecureField("비밀번호를 입력하세요.", text: $passwordRepeat)
                            .modifier(SignViewTextFieldModifier())
                        
                        Button(action: {
                            self.passwordRepeatShow.toggle()
                        }, label: {
                            Image(systemName: "eye.slash")
                                .foregroundColor(.secondary)
                        })
                    }
                }
                .modifier(SignViewModifier())
                
                // 2회 입력 비밀번호 일치 여부 확인 코드
                Text(passwordCheck ? "" : "비밀번호가 동일하지 않습니다.")
                    .modifier(SignViewTextAlertModifier())
                    .onReceive([password, passwordRepeat].publisher) { _ in
                        passwordCheck = password == passwordRepeat
                        print("passwordCheck: \(passwordCheck)")
                    }
                
                // MARK: - 회원가입 이름 입력
                TextField("이름을 입력하세요.", text: $userName)
                    .modifier(SignViewTextFieldModifier())
                    .modifier(SignViewModifier())
            }
            
            // MARK: - 회원가입 버튼
            HStack {
                Spacer()
                
                Button {
                    if !isValidEmail(email: id) {
                        showAlert = true
                        showAlertMessage = "이메일 형식으로 작성해야 합니다."
                    } else if password.count < 6 {
                        showAlert = true
                        showAlertMessage = "비밀번호는 6자리 이상으로 설정해야합니다."
                    }
                    Task {
                        try await AuthService.shared.createUser(withEmail: id, password: password, userName: userName) { createCheck in
                            if createCheck {
                                Task{
                                    try await myInfoStore.fetchMyInfo()
                                }
                                path = []
                            }
                        }
                    }
                } label: {
                    Text("회원가입")
                }
                
                Spacer()
            }
            .padding()
            .background(!id.isEmpty && !password.isEmpty && !passwordRepeat.isEmpty && !userName.isEmpty && !idCheck && passwordCheck ? Color.blue : Color.gray)
            .cornerRadius(5)
            .foregroundColor(!idCheck && passwordCheck && !userName.isEmpty ? .white : .black)
            
            //버튼 비활성화 로직
            .disabled(idCheck || !passwordCheck)
            .disabled(id.isEmpty || password.isEmpty || passwordRepeat.isEmpty || userName.isEmpty)
        }
        .padding()
        .alert(showAlertMessage, isPresented: $showAlert) {
            Button("OK") {}
        }
        .navigationTitle("회원가입")
    }
}

// MARK: - 이메일 정규식
func isValidEmail(email:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: email)
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(path: .constant([]), myInfoStore: MyInfoStore())
    }
}
