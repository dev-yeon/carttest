//
//  iPhoneProductView.swift
//  AppleStore
//
//  Created by SIKim on 2023/09/05.
//

import SwiftUI

struct iPhoneProductView: View {
    @ObservedObject var itemStore: ItemStore
    private var isNewProduct: Bool {
        itemStore.itemInfo.status == 3
    }
    @State private var isShowingMoreInfo: Bool = false
    
    var body: some View {
        VStack {
            
            Text(isNewProduct ? "New" : "")
                .padding(2)
                .font(.caption2)
                .foregroundColor(.orange)
            Text("\(itemStore.itemInfo.seriesName) 구입하기")
                .font(.title)
                .fontWeight(.bold)
            AsyncImage(url: URL(string: itemStore.userPickItem.mainImageString)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
            } placeholder: {
                Image(systemName: "xmark.app")
            }
            .padding(.top)
            
            
//            Divider()
            
            Button {
                isShowingMoreInfo.toggle()
            } label: {
                Text("더 알아보기")
                    .font(.footnote)
                    .padding()
                    .frame(maxWidth: .infinity)
                //                                            .border(Color(.systemGray5))
            }
            
            Divider()
        }
        .onAppear {
            itemStore.updateDefaultData()
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
    }
}

struct iPhoneProductView_Previews: PreviewProvider {
    static var previews: some View {
            iPhoneProductView(itemStore: ItemStore())
    }
}
