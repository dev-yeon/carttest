//
//  NaverMap.swift
//  AppleStore
//
//  Created by 박성훈 on 2023/09/06.
//

import SwiftUI
import NMapsMap

struct NaverMap: UIViewRepresentable {
    
    // Coordinator - SwiftUI로 데이터 전달(delegate 역할)
    func makeCoordinator() -> MapCoordinator {
        MapCoordinator.shared
    }
    
    // SwiftUI에서 UIKit으로 전달
    func makeUIView(context: Context) -> NMFNaverMapView {
        context.coordinator.view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}


