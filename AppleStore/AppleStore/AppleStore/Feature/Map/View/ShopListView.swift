//
//  ShopListView.swift
//  AppleStore
//
//  Created by 김효석 on 2023/09/07.
//

import SwiftUI
import Kingfisher

struct ShopListView: View {

    @StateObject var shopDataStore: ShopDataStore
    @State var userLocation = MapCoordinator.shared.userLocation
    
    let shopDatas: [ShopModel]
    
    var body: some View {
        List {
            Section {
                ForEach(shopDataStore.sortShopsByDistance(shopDatas)) { shopData in
                    NavigationLink {
                        ShopDetailView(shopData: shopData, shopDataStore: shopDataStore, isNavigated: true)
                    } label: {
                        HStack(alignment: .center) {
                            KFImage(URL(string: shopData.imageURLString))
                                .placeholder {
                                    Image(systemName: "apple.logo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 80, height: 80)
                                }
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 115)
                            
                            VStack(alignment: .leading) {
                                Text(shopData.shopName)
                                    .font(.body)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                                Text(shopData.city)
                                    .font(.caption)
                                Text(shopData.hours[shopDataStore.getWeekdayInt()])
                                    .font(.caption)
                                Text("현 위치에서 거리: \(MapCoordinator.shared.distancePresentToDestination(shopData.latitude, shopData.longitude)) km")
                                    .font(.caption)                            }
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                            
                        }
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
                        
                    }
                        .padding(0)
                }
            } header: {
                Text("근처 매장")
            }
        }
        .navigationTitle("매장 찾기")
        .navigationBarTitleDisplayMode(.inline)
        .refreshable {
            MapCoordinator.shared.fetchUserLocation()
        }
        .onAppear {
            MapCoordinator.shared.isNavigationMapView = false
        }
    }
}


struct ShopListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ShopListView(shopDataStore: ShopDataStore(), shopDatas: ShopDataStore().shopDatas)
        }
    }
}
