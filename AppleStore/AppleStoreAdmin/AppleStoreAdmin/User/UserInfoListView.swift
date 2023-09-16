//
//  UserInfoListView.swift
//  AppleStoreAdmin
//
//  Created by woojin Shin on 2023/09/05.
//

import SwiftUI

// MARK: - 회원목록
struct UserInfoListView: View {
    
    @State var isShowingSheet: Bool = false
    @State var text: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                ///사용자들 이름을 넣어주어야 한다.
                ///데이터 모델 만든 후 ForEach 없애야 함
                ForEach(0..<10) { _ in
                    Button {
                        isShowingSheet = true
                    } label: {
                        Text("사용자 정보")
                            .tint(.black)
                    }
                    .sheet(isPresented: $isShowingSheet) {
                        UserInfoSheet(isShowingSheet: $isShowingSheet)
                    }
                }
                .listRowBackground(Color.init(hex: "EEEEEE"))
                ///리스트를 지우는 modifier 사용
                 //.onDelete(perform: )
            }
            
            //            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .background(Color.init(hex: "9BABB8"))
            .navigationTitle("회원목록")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button {
                            
                        } label: {
                            Text("검색")
                                .tint(.black)
                        }
                        
                        TextField(text: $text) {
                            Text("이름을 적으세요")
                        }
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 200)
                    }
                }
            }
        }
    }
    ///List 내용을 지우는 Method 생성
//    func deleteItem(at offsets: IndexSet) {
//        items.remove(offsets)
//        }
}

struct UserInfoListView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoListView()
    }
}
