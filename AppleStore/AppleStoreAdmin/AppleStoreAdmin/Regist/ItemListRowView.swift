//
//  ItemListRowView.swift
//  AppleStoreAdmin
//
//  Created by woojin Shin on 2023/09/11.
//

import SwiftUI
import Kingfisher
import AppleStoreCore

struct ItemListRowView: View {
    let item: ItemInfo
    
    @Binding var selectIndexID: String
    
    var body: some View {
        HStack {
            KFImage(URL(string: item.mainImageString))
                .placeholder({ _ in
                    VStack{
                        ProgressView()
                        Text("이미지 로드중")
                    }
                }).retry(maxCount: 3, interval: .seconds(5))
//                .onSuccess({ r in
//                    print("success: \(r)")
//                })
//                .onFailure({ e in
//                    print("fail: \(e)")
//                })
                .cancelOnDisappear(true)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            
            Divider()
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 8) {
                Text(item.productName)
                Text("\(item.price)원")
                Text(item.storage)
                
                HStack {
                    Circle()
                        .fill(Color(hex: item.productColor.getNameColor[1]))
                        .frame(width: 20)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)

            }
            .font(.subheadline)
            
        }
        .padding()
        .padding(.horizontal, 5)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .stroke(selectIndexID == item.id ? Color(hex: "534340") : Color(hex: "E4E4D0"))
            
        }
        .contentShape(RoundedRectangle(cornerRadius: 8))
        .listRowBackground(Color.clear)
    }
}

struct ItemListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRegistEditView()

//        ItemRegistListView(model: ItemViewModel())
    }
}
