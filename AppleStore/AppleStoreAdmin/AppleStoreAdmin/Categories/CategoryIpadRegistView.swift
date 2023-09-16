//
//  CategoryIpadRegistView.swift
//  AppleStoreAdmin
//
//  Created by woojin Shin on 2023/09/07.
//

import SwiftUI

struct CategoryIpadRegistView: View {
    private let type: ItemType = .ipad
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(type.rawValue)")
                    .font(.largeTitle)
                    .padding(.horizontal, 20)
            }
            
            HStack {
                CategorySubView(titleName: .series,  itemType: type, model: CategoryModel())
                CategorySubView(titleName: .embedCellular,  itemType: type, model: CategoryModel())
            }
            
            HStack {
                CategorySubView(titleName: .color,  itemType: type, model: CategoryModel())
                CategorySubView(titleName: .storage, itemType: type, model: CategoryModel())
            }

//            CategorySubView(titleName: .ipadInch, itemType: type, model: CategoryModel())
            
        }
        .padding()
    }
}

struct CategoryIpadRegistView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryIpadRegistView()
    }
}
