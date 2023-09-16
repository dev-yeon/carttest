//
//  ItemRegistEditView.swift
//  AppleStoreAdmin
//
//  Created by woojin Shin on 2023/09/05.
//

import SwiftUI



struct ItemRegistEditView: View {
    @StateObject private var itemModel: ItemViewModel = .init()
    
    @State private var itemWhereData: String = "" //여러개 아님
    @State private var dtlWhereDatas: [[String:String]] = .init()
    
    
    var body: some View {
        let itemRegistListView = ItemRegistListView(model: itemModel, itemWhereData: $itemWhereData, dtlWhereDatas: $dtlWhereDatas)
        
        return GeometryReader { geometry in
//            ZStack {
                VStack {
                    ItemOptionView(itemModel: itemModel, itemWhereData: $itemWhereData, dtlWhereDatas: $dtlWhereDatas, fetchData: { itemRegistListView.fetchData() })
                        .padding(.horizontal, 20)
//                        .frame(height: 100)
                    
                    
                    HStack {
//                        ItemRegistListView(model: itemModel)
                        itemRegistListView
                            .hideKeyboardOnTap()
                        
                        Spacer()
                        Divider()
                        
                        Group {
                            if !itemModel.itemInfo.productName.isEmpty {
                                ItemRegistAddView(model: itemModel, isSingle: false) //등록뷰
                            } else {
                                Text("선택한 항목의 상세정보가 표시됩니다.")
                                    .foregroundColor(.gray)
                            }
                            
                        }
                        .frame(width: geometry.size.width * 0.6)
                    }
                }
//            }
            .hideKeyboardOnTap()
        }
    }
    
}

struct ItemRegistEditView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRegistEditView()
            .previewDevice("iPad Pro (11-inch) (4th generation)")
            
    }
}
