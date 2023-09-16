//
//  MapView.swift
//  AppleStoreAdmin
//
//  Created by 송성욱 on 2023/09/07.
//

import SwiftUI
import MapKit

struct AnnotatedItem: Identifiable {
    let id: UUID = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct MapView: View {
 
    var appleShop: ShopModel

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.51371787, longitude: 127.10494937),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    @State private var annotatedItems: [AnnotatedItem] = []
    
    // 맵의 중앙 위치가 자동으로 안바뀌면 아래의 Bool 값을 활용한 코드가 도움이 된다.
    @State private var isCompleted: Bool = false
    
    var body: some View {
        VStack {
            if isCompleted {
                Map(coordinateRegion: $region, annotationItems: annotatedItems) { annotatedItem in
                    MapMarker(coordinate: annotatedItem.coordinate, tint: .purple)
                }
            }
        }
//        .navigationTitle("위치보기")
        .onAppear {
            let coordinate = CLLocationCoordinate2D(latitude: appleShop.latitude, longitude: appleShop.longitude)
            
            let annotatedItem = AnnotatedItem(name: appleShop.shopName, coordinate: coordinate)
            
            annotatedItems = [annotatedItem]
            
            region.center = coordinate
            
            isCompleted = true
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MapView(appleShop: ShopDataStore().sampleData)
        }
    }
}
