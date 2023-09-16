//
//  SearchBar.swift
//  AppleStoreAdmin
//
//  Created by 송성욱 on 2023/09/12.
//

import SwiftUI
import AppleStoreCore

struct SearchBar: View {
//    @Binding var userDatas: [User]
    @Binding var text: String
    @State var editText: Bool = false
    
//    var filteredItems: [String] {
//        if text.isEmpty {
//            return items
//        } else {
//            return items.filter { $0.localizedCaseInsensitiveContains(searchText) }
//        }
//    }
    
    var body: some View {
        HStack {
            TextField("검색어를 입력하세요", text: self.$text)
                .padding()
                .padding(.horizontal, 15)
                .background(Color(.systemGray6))
                .cornerRadius(20)
                .overlay {
                    HStack {
                        Spacer()
                        if self.editText {
                            Button {
                                self.editText = false
                                self.text = ""
                                
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.black)
                                    .padding()
                            }
                            
                        } else {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                                .padding()
                        }
                    }
                }
                .onTapGesture {
                    self.editText = true
                }
        }
    }
}
struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoListView()
//        SearchBar(text: .constant(""))
    }
}
