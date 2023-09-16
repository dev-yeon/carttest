//
//  LoginView.swift
//  AppleStoreAdmin
//
//  Created by woojin Shin on 2023/09/05.
//

import SwiftUI


struct LoginView: View {
    
    enum FocusableField: Hashable {
        case userId
        case userPassword
    }
    
    @State var userId: String = ""
    @State var userPassword: String = ""
    @State private var validMsg : String = ""
    @State private var isLogined: Bool = false
    @FocusState var focusField: FocusableField?
    
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.init(hex: "CEE6F3")
                    .ignoresSafeArea()
                VStack {
                    
                    Image(systemName: "applelogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .foregroundColor(Color.init(hex: "344D67"))

                    Text("for admin")
                        .padding()
                        .font(.title2)
                    
                    Spacer().frame(height: 100)
                    
                    TextField("ID", text: self.$userId)
                        .focused($focusField, equals: .userId)
                        .textFieldStyle(CustomTextFieldStyle())
                    
                    Spacer().frame(height: 20)
                    
                    HStack {
                        SecureField("Password", text: self.$userPassword)
                            .focused($focusField, equals: .userPassword)
                            .textFieldStyle(CustomTextFieldStyle())
                        
                    }
                    
                    Spacer().frame(height: 50)
                    HStack {
                        Button {
                            //계정이 일치하면 화면이 넘어간다.
                            onTouchEntrance()
                        } label: {
                            Text("sign in")
                                .font(.title2)
                        }
                        
                        Text("|")
                        
                        Button {
                            ///계정이 일치하면 화면이 넘어간다.
                        } label: {
                            Text("sign up")
                                .font(.title2)
                        }
                    }
                    Text(validMsg)
                        .padding()
                        .foregroundColor(Color.init(hex: "999999"))
                }
            }
            .navigationDestination(isPresented: $isLogined) {
                MainView()
                    .navigationBarBackButtonHidden(true)
            }
            
        }
        
    }
    ///로그인 상태 메세지를 알려주는 함수
    /////계정이 일치하면 화면이 넘어간다.
    func onTouchEntrance(){
        
        print("onTouchEntrance Load")
        
        if userId.isEmpty{
            focusField = .userId
            validMsg = "사용자 아이디를 입력해주세요."
            
            return
        }
        else if userPassword.isEmpty {
            focusField = .userPassword
            validMsg = "비밀번호를 입력해주세요."
            
            return
        } else{
            focusField = nil
            validMsg = ""
            isLogined.toggle()
            
        }
    }
}
///커스텀 TextField 입니다.
struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.init(hex: "344D67"), lineWidth: 2))
            .frame(width: 500)
            .foregroundColor(.black)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
