//
//  UserInfoListView.swift
//  AppleStoreAdmin
//
//  Created by woojin Shin on 2023/09/05.
//

import SwiftUI
import AppleStoreCore

// MARK: - 회원목록
struct UserInfoListView: View {
    @StateObject var userInfoStore: UserInfoStore = UserInfoStore()
    
    @State private var text: String = ""
    @State private var isSelected: User.ID?
    
    var body: some View {
        NavigationStack {

            HStack {
                Text("회원목록")
                    .font(.largeTitle)
                
                Spacer()
                    .padding(.horizontal)
                
                ///검색창.
                SearchBar(text: $text)
            }
            .contentShape(Rectangle())
            
            Divider()
            
            Text("\(userInfoStore.users.count)명 생존")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .foregroundColor(.gray)
            
            Table(userInfoStore.users, selection: $isSelected) {

                TableColumn("회원 ID") { info in

                    HStack{
                        Text("\(info.id)")
                    }
                }
                    
                TableColumn("회원명") { info in
                    HStack{
                        Text("\(info.userName)")
                    }
                }
                .width(100)
                    
                TableColumn("E-mail") { info in
                    Text("\(info.email)")
                }
                

                TableColumn("전화번호") { info in
                    Text("\(info.phone ?? "[전화번호 없음]")")
                        .bold()
                }
                
                TableColumn("주소") { info in
                    Text("\(info.headAddress ?? "[주소 없음]")")
                        .bold()
                }
                
                TableColumn("상세") { info in
                    Menu {
                        NavigationLink {
                            if let userInfo = userInfoStore.getUserInfo(id: info.uid) {
                                UserInfoSheet(userModel: userInfoStore, user: userInfo)
                            }
                        } label: {
                            Label("회원정보 상세", systemImage: "list.bullet.below.rectangle")
                        }
                        
                    } label: {
                        Label("상세", systemImage: "ellipsis.circle")
                            .labelStyle(.iconOnly)
                            .contentShape(Rectangle())
                            .tint(.black)
                    }
                }
                .width(100)
                
            }
            
        }
        .padding()
        .hideKeyboardOnTap()
        .onAppear {
            userInfoStore.fetchUserInfos()
        }
        .refreshable {
            userInfoStore.fetchUserInfos()
        }
    }
}

struct UserInfoListView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoListView()
    }
}
