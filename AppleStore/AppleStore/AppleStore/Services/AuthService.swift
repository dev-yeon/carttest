//
//  AuthService.swift
//  AppleStore
//
//  Created by 윤해수 on 2023/09/06.
//

import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

final class AuthService: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    //singleton Pattern
    static let shared = AuthService()
    
    private init() {
        self.userSession = Auth.auth().currentUser
    }
    
    /// 로그인 기능 - Auth를 통한 계정 정보 확인
    func signIn(withEmail: String, password: String) async throws -> (Bool, String) {
        do {
            let result = try await Auth.auth().signIn(withEmail: withEmail, password: password)
            
            let tempUserSession = result.user
            let snapshot = try await Firestore.firestore().collection("Users").document(tempUserSession.uid).getDocument()
            print("signIn: \(snapshot)")
            
            self.userSession = result.user
            try await UserService.shared.fetchUser()
            return (result : false, message : "")
            
        } catch {
            print("debug : Failed to Login In with \(error.localizedDescription)")
            print(String(describing: error))
            return (result : true, message : "이메일 또는 비밀번호가 다릅니다.")
        }
    }
    
    /// 계정 생성 기능 - Auth를 통한 계정 정보 생성
    @MainActor
    func createUser(withEmail email: String, password: String, userName: String, createCheck: @escaping(Bool) -> Void) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await uploadUserData(withEmail: email, userName: userName, id: result.user.uid)
            createCheck(true)
            print("debug : Create User \(result.user.uid)")
        } catch {print(String(describing: error))
            print("debug : Failed to Create User with \(error.localizedDescription)")
            createCheck(false)
        }
    }
    
    /// 계정 중복 여부 확인 기능 - 입력받는 이메일 중복 여부 확인
    func checkUserID(withEmail: String, idCheck: @escaping (Bool) -> Void) {
        // Auth의 매소드를 통한 이메일 중복 여부 확인
        Auth.auth().fetchSignInMethods(forEmail: withEmail) { (methods, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                idCheck(false)
            } else if methods != nil {
                idCheck(true)
            } else {
                idCheck(false)
            }
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut() // 백엔드 ( 서버에서 로그아웃 )
        self.userSession = nil // 앱에서 세션을 제거하고 라우팅 업데이트
        UserService.shared.reset() // sets current User -> nil
    }
    
    func uploadUserData(
        withEmail email: String,
        userName: String,
        id: String
    ) async throws {
        let user = User(uid: id, userName: userName, email: email)
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("Users").document(id).setData(userData)
        UserService.shared.currentUser = user
    }
}
