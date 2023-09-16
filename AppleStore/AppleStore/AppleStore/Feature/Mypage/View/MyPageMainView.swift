//
//  MyPageMainView.swift
//  AppleStore
//
//  Created by dayexx on 2023/09/05.
//
import SwiftUI

struct MyPageMainView: View {
    @StateObject private var myInfoStore: MyInfoStore = MyInfoStore()
    @StateObject private var myPageStore: MyPageStore = MyPageStore()
    @State private var isShowingAddressSheet: Bool = false
    @State private var detent: PresentationDetent = .medium
//    var isLogin: Bool {
//        UserService.shared.currentUser != nil
//    }
//    @State private var isLogin: Bool = false
    @State private var path : [String] = []
    
    
    var body: some View {
        NavigationStack(path: $path) {
            if myPageStore.userSession == nil {
                GuestView(myInfoStore: myInfoStore, path: $path)
            }
            else{
                List {
                    
                    /* 사용자 정보 */
                    MyProfileView(myInfo: myInfoStore.myInfo)
                    
                    /* 사용자 기능 */
                    Section{
                        NavigationLinkRow(OrderListView(),"주문")
                        NavigationLinkRow(BookMarkView(),"저장 목록")
                    }.padding()
                    
                    /* 사용자 설정 */
                    Section{
                        Button("배송지"){
                            isShowingAddressSheet = true
                        }.foregroundColor(.black)
                        Button("설정"){
                            showingSettingView()
                        }.foregroundColor(.black)
                    }.padding()
                    
                    /* 도움 */
                    NavigationLinkRow(SupportView(),"도움받기").padding()
                    NavigationLinkRow(MapView(),"지도 페이지")
                        .padding()
                    Button {
                        print(myPageStore.userSession)
                        print(myInfoStore.myInfo)
                    } label: {
                        Text("현재 세션, 로그인 정보 조회")
                    }
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Text("로그아웃")
                    }
                    
                }
                .navigationTitle("계정")
                .sheet(isPresented: $isShowingAddressSheet){
                    NavigationStack{
                        AddressSettingView(myInfoStore: myInfoStore, isShowingAddressSheet: $isShowingAddressSheet)
                    }/*.presentationDetents([
                      .medium,
                      .large
                      ], selection : $detent)*/
                }
            }
        }
//        .onAppear {
//            Task{
//                try await myInfoStore.fetchMyInfo()
//            }
//        }
    }
    // 시스템 설정으로 보냄
    func showingSettingView() {
        if let appSettingsURL = URL(string: UIApplication.openSettingsURLString) { //iOS에서 제공하는 설정창 상수 URL
            if UIApplication.shared.canOpenURL(appSettingsURL) { //상태 확인
                UIApplication.shared.open(appSettingsURL, options: [:], completionHandler: nil)//URL, 기본설정으로 열기
            }
        }
    }
    
    func NavigationLinkRow(_ View: some View,_ text: String) -> some View {
        NavigationLink{
            View
        } label: {
            Text(text)
        }
    }
}

struct MyPageMainView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageMainView()
    }
}
