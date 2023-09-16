//
//  User.swift
//  AppleStore
//
//  Created by daye on 2023/09/12.
//
import SwiftUI
import FirebaseFirestore

/*
 struct MyInfo: Identifiable,Codable {
 var id: String = UUID().uuidString // 유저의 Auth 고유 아이디.
 var userName: String          // 유저 이름
 var email: String             // 이메일
 var imageURLString: String?   // 프로필
 var postal: String?      // 우편번호
 var headAddress: String?      // 주소
 var detailAddress: String?   // 상세주소
 var nation: String?           // 국가
 var phone: String?            // 핸드폰
 }
 */

//SSF5uC4OBndmE8GGu58kMlH8YUn1

//mypage
//123123

class MyInfoStore: ObservableObject {
    @Published var myInfo: User = User(uid: "", userName: "Guest", email: "")
    
    var tempUser: User? = UserService.shared.currentUser
    let dbRef = Firestore.firestore().collection("Users")
    
    init() {
        Task {
            try await fetchMyInfo()
        }
    }
    
    func fetchMyInfo() async throws {
        
        print("----------------")
        print("loginUser")
        print(UserService.shared.currentUser)
        print("----------------")
        
        if let loginUserID = UserService.shared.currentUser?.uid {
            do {
                let document = try await dbRef.document(loginUserID).getDocument()
                let userInfo = try document.data(as: User.self)
                DispatchQueue.main.async {
                    self.myInfo = userInfo
                }
            } catch let error {
                print("fetchMyInfo : \(error.localizedDescription)")
            }
            //        dbRef.document(loginUserID).getDocument { (document, error) in
            //            if let document = document, document.exists {
            //                let userInfo = try document.data(as: User.self)
            //                let docData: [String: Any] = document.data() ?? [:]
            //
            //                let userName: String = docData["userName"] as? String ?? "Guest"
            //                let email: String = docData["email"] as? String ?? ""
            //                let imageURLString: String? = docData["profileImageURL"] as? String ?? ""
            //                let postal: String? = docData["postal"] as? String ?? ""
            //                let headAddress: String? = docData["headAddress"] as? String ?? ""
            //                let detailAddress: String? = docData["detailAddress"] as? String ?? ""
            //                let nation: String? = docData["nation"] as? String ?? ""
            //                let phone: String? = docData["phone"] as? String ?? ""
            //
            //                let info = User(userName: userName, email: email, imageURLString: imageURLString, postal: postal, headAddress: headAddress, detailAddress: detailAddress, nation: nation, phone: phone)
            
        }
    }
    func saveAddress(_ myInfo: User) async {
        var tempInfo: User = myInfo
        
        tempInfo.postal = myInfo.postal
        tempInfo.headAddress = myInfo.headAddress
        tempInfo.detailAddress = myInfo.detailAddress
        tempInfo.nation = myInfo.nation
        tempInfo.phone = myInfo.phone
        
        guard let myInfoData = try? Firestore.Encoder().encode(tempInfo) else { return }
        
        if let loginUserID = UserService.shared.currentUser?.uid {
            do {
                try await dbRef.document(loginUserID).setData(myInfoData)
                try await fetchMyInfo()
            } catch let error {
                print("saveAddress - fetchMyInfo : \(error.localizedDescription)")
            }
        }
    }
}
