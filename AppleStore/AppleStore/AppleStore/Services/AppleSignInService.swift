//
//  AppleSignInService.swift
//  AppleStore
//
//  Created by 윤해수 on 2023/09/14.
//

import Foundation
import Firebase
import CryptoKit
import AuthenticationServices

class AppleSignInService: ObservableObject {
    
    func authenticate(credential: ASAuthorizationAppleIDCredential) {
        // 난수 확인
        guard let nonce = currentNonce else {
            fatalError("Invalid state: A login callback was received, but no login request was sent.")
        }
        //
        guard let token = credential.identityToken else {
            print("error with firebase")
            return
        }
        // 토큰 확인
        guard let tokenString = String(data: token, encoding: .utf8) else {
            print("error with token")
            return
        }
        
        let fullName = "\(credential.fullName?.givenName ?? "") \(credential.fullName?.familyName ?? "")"
        print("fullname: \(fullName)")
        print("fullname1: \(credential.fullName?.givenName ?? "no")")
        print("fullname2: \(credential.fullName?.familyName ?? "no")")
                
        let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
        Auth.auth().signIn(with: credential) { result, err in
            // 로그인 실패 시
            if let err = err {
                print(err.localizedDescription)
            }
            // 로그인 성공 시
            
            if let user = result?.user {
                print("사용자 ID: \(user.uid)")
                print("사용자 ID: \(user)")
                print("사용자 이메일: \(user.email ?? "N/A")")
                Task {
                    try await AuthService.shared.uploadUserData(withEmail: user.email ?? "N/A", userName: fullName, id: user.uid)
                }
                
                print("로그인 완료")
            }
        }
    }
}

// Helper for Apple Login with Firebase
func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
    }.joined()
    
    return hashString
}

private func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    var randomBytes = [UInt8](repeating: 0, count: length)
    let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
    if errorCode != errSecSuccess {
        fatalError(
            "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
    }
    
    let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    
    let nonce = randomBytes.map { byte in
        // Pick a random character from the set, wrapping around if needed.
        charset[Int(byte) % charset.count]
    }
    
    return String(nonce)
}

fileprivate var currentNonce: String?

func startSignInWithAppleFlow() {
    let nonce = randomNonceString()
    currentNonce = nonce
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    let request = appleIDProvider.createRequest()
    request.requestedScopes = [.fullName, .email]
    request.nonce = sha256(nonce)
}
