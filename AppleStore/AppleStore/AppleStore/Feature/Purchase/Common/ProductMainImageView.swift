//
//  iPhoneProductView.swift
//  AppleStore
//
//  Created by SIKim on 2023/09/05.
//

import SwiftUI

struct ProductMainImageView: View {
    @ObservedObject var itemStore: ItemStore
    private var isNewProduct: Bool {
        guard !itemStore.selectedItems.isEmpty else { return false }
        return itemStore.selectedItems[0].status == 3
    }
    private var imageURLString: String {
        guard !itemStore.selectedItems.isEmpty else { return ""}
        return itemStore.selectedItems[0].mainImageString
    }
    @State private var isShowingMoreInfo: Bool = false
    let seriesName: String
    
    var body: some View {
        VStack {
            VStack {
                Text(isNewProduct ? "New" : "")
                    .padding(4)
                    .font(.caption2)
                    .foregroundColor(.orange)
                Text("\(seriesName)")
                    .font(.title)
                    .fontWeight(.bold)
                AsyncImage(url: URL(string: imageURLString)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Image(systemName: "xmark.app")
                }
                .padding()
            }
            .padding()
            //                    .border(Color(.systemGray5))
            Divider()
            
            HStack(alignment: .top) {
                Button {
                    isShowingMoreInfo.toggle()
                } label: {
                    Text("더 알아보기")
                        .font(.footnote)
                        .padding()
                        .frame(maxWidth: .infinity)
                    //                                            .border(Color(.systemGray5))
                }
            }
            .fullScreenCover(isPresented: $isShowingMoreInfo, content: {
                NavigationStack {
                    Text("더 알아보기 준비중")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    isShowingMoreInfo.toggle()
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.black)
                                }
                            }
                        }
                }
            })
            
            Divider()
        }
    }
}

struct ProductMainImageView_Preview: PreviewProvider {
    static var previews: some View {
        ProductMainImageView(itemStore: ItemStore(), seriesName: "iPad Air")
    }
}


//var getNameColor: [String] {
//    let components = self.split(separator: "/").map { String($0) }
//
//    var returnValue = components.isEmpty ? [""] : components
//
//    //무조건 2개의 값을 만들어서 런타임에러 방지 ㅋㅎ
//    for index in 0..<2 {
//        //값이 있으면 패스 없으면 넣어준다.
//        if !returnValue.indices.contains(index) {
//            returnValue.insert("", at: index)
//        }
//    }
//
////        print("reee \(returnValue)")
//
//    return returnValue
//}
