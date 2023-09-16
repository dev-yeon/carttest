//
//  MapView.swift
//  AppleStore
//
//  Created by 박성훈 on 2023/09/06.
//

import SwiftUI
import NMapsMap

enum SegmentIndex {
    case list
    case map
}

struct MapView: View {
    @StateObject private var shopDataStore: ShopDataStore = ShopDataStore()
    @ObservedObject private var mapCoordinator: MapCoordinator = MapCoordinator.shared
    
    @State private var segmentIndex: SegmentIndex = .list
    @State private var searchText: String = ""
    
    // 데이터 필터링(shopName / city / postCode)
    var filteredDatas: [ShopModel] {
        if searchText.isEmpty {
            return shopDataStore.shopDatas
        } else {
            return shopDataStore.shopDatas.filter { $0.shopName.localizedCaseInsensitiveContains(searchText) || $0.city.localizedCaseInsensitiveContains(searchText) ||
                $0.postCode.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText, filteredDatas: filteredDatas)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 12, trailing: 20))
            
            HStack {
                Picker("How showing shopInfo", selection: $segmentIndex) {
                    Text("목록").tag(SegmentIndex.list)
                    Text("지도").tag(SegmentIndex.map)
                }
            }
            .pickerStyle(.segmented)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            switch segmentIndex {
            case .list:
                ShopListView(shopDataStore: shopDataStore, shopDatas: filteredDatas)
            case .map:
                ZStack {
                    NaverMap()
                        .navigationTitle("매장 찾기")
                        .navigationBarTitleDisplayMode(.inline)
                        .onAppear {
                            MapCoordinator.shared.makeMarkers(shopDatas: filteredDatas)
                            MapCoordinator.shared.removePathLine()
                        }
                    if MapCoordinator.shared.isShowingPathLine {
                        VStack{
                            Spacer()
                            HStack {
                                Button {
                                    MapCoordinator.shared.removePathLine()
                                    MapCoordinator.shared.removeMarkers()
                                    MapCoordinator.shared.makeMarkers(shopDatas: filteredDatas)
                                    MapCoordinator.shared.moveCameraToUserLocation()
                                    
                                } label: {
                                    Text("경로 지우기")
                                        .padding(10)
                                }
                                .background(.blue)
                                .cornerRadius(5)
                                .foregroundColor(.white)
                                .font(.body)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $mapCoordinator.isShowingMarkerDetailView) {
                ShopDetailView(shopData: shopDataStore.shopDatas.filter {
                    $0.shopName == mapCoordinator.currentShopId
                }[0], shopDataStore: shopDataStore, isNavigated: false)
                .presentationDragIndicator(.visible)
                
        }
        .onAppear {
            shopDataStore.fetchShopDatas()
            mapCoordinator.checkLocationServiceIsEnabled()
            mapCoordinator.removeMarkers()
        }
        .onChange(of: self.searchText) { newValue in
            mapCoordinator.removeMarkers()
            mapCoordinator.makeMarkers(shopDatas: filteredDatas)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MapView()
        }
    }
}
