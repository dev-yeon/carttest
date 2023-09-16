//
//  UserInfoSheet.swift
//  AppleStoreAdmin
//
//  Created by 송성욱 on 2023/09/05.
//

import SwiftUI
import AppleStoreCore


// MARK: - 사용자 정보
struct UserInfoSheet: View {
    @ObservedObject var userModel: UserInfoStore
    let user: User

    var body: some View {

        VStack {

            List {
                Section("사용자 이름") {
                    Text("\(user.userName)")
                }
                Section("email") {
                    Text("\(user.email)")
                        .tint(.black)
                }
                Section("휴대전화번호") {
                    Text("\(user.phone ?? "[전화번호 없음]")")
                }
                Section("주소 / 우편번호") {
                    Text("\(user.headAddress ?? "") \(user.detailAddress ?? "")")
                    Text("0101")
                }
                Section("국가") {
                    Text("대한민국")
                }
            }
        }

    }
}


//struct UserInfoSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            UserInfoSheet(userModel: UserInfoStore(), isShowingSheet: .constant(true))
//        }
//    }
//}
