//
//  SearchShopView.swift
//  AppleStore
//
//  Created by 박성훈 on 2023/09/11.
//

import SwiftUI

struct SearchBar: View {
    
    /// 포커스필드를 위한 열거형
    enum Field: Hashable {
            case searchShopTextField
    }
        
    @FocusState private var focusedField: Field?

    @State private var isEditing: Bool = false
    @Binding var searchText: String
    
    var filteredDatas: [ShopModel]
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .onTapGesture {
                        self.isEditing = true
                        self.focusedField = .searchShopTextField
                    }
                
                TextField("도시, 우편번호, 이름으로 검색", text: $searchText)
                    .textFieldStyle(.plain)
                    .focused($focusedField, equals: .searchShopTextField)
                    .textInputAutocapitalization(.never)
                    .onSubmit {
                        self.isEditing = false
                        // return 시 해당 지점으로 카메라 이동
                        if searchText == filteredDatas[0].shopName ||
                            searchText == filteredDatas[0].city ||
                            searchText == filteredDatas[0].postCode {
                            MapCoordinator.shared.moveCameraToSearchLocation(filteredShopDatas: filteredDatas)
                        }
                    }
                    .onTapGesture {
                        self.isEditing = true
                    }
                
                if !searchText.isEmpty {
                    Button {
                        self.searchText = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                    }
                    .foregroundColor(.gray)
                }
            }
            .padding(7)
            .font(.title3)
            .background(Color(uiColor: .systemGray6))
            .cornerRadius(6)
            
            if isEditing {
                Button {
                    self.isEditing = false
                    self.searchText = ""
                    // 키보드 내려놓기
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                } label: {
                    Text("취소")
                }
            }
        }
            
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""), filteredDatas: ShopDataStore().shopDatas)
    }
}
