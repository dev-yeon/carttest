//
//  ShopRegistListShop.swift
//  AppleStoreAdmin
//
//  Created by 송성욱 on 2023/09/07.
//

import SwiftUI
import Kingfisher

// MARK: -  동록된 AppleStore 리스트 뷰
struct ShopRegistListShop: View {
    
    @ObservedObject var appleShopStore: ShopDataStore = ShopDataStore()
    
    @State var isShowingSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(appleShopStore.shopDatas) { appleShop in
                    NavigationLink {
                        ShopDetailView(appleShop: appleShop)
                        
                    } label: {
                        HStack(spacing: 200) {
                            KFImage(URL(string: appleShop.imageURLString))
                                .placeholder({ _ in
                                    ProgressView()
                                        .foregroundColor(.gray)
                                    
                                }).retry(maxCount: 3, interval: .seconds(5))
                                .cancelOnDisappear(true) //셀이 화면에서 안보일때는 로드하지 않음.
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 300, height: 200)
                            
                            
                            VStack(alignment: .trailing) {
                                Text(appleShop.shopName)
                                    .font(.system(size: 30))
                                    .fontWeight(.heavy)
                            }
                        }
                    }
                }
                .onDelete { offsets in
                    appleShopStore.removeShop(at: offsets)
                }
            }
            .onAppear {
                appleShopStore.fetchData()
            }
            .refreshable {
                appleShopStore.fetchData()
            }
            .listStyle(.plain)
            

            NavigationLink {
                ShopRegistSheet(appleShop: ShopDataStore().sampleData, isShowingSheet: $isShowingSheet)
                    
            } label: {
                PlusButtonVIew()
            }
            
        }
        .padding()
    }
}

struct ShopRegistListShop_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            
            ShopRegistListShop()
        }
    }
}
