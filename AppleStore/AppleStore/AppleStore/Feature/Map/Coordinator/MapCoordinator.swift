//
//  MapCoordinator.swift
//  AppleStore
//
//  Created by 김효석 on 2023/09/11.
//

import Foundation
import NMapsMap

// MARK: - Coordinator
// 카메라 == 지도에서 위치
// NMFMapViewCameraDelegate - 카메라 이동에 필요한 델리게이트
// NMFMapViewTouchDelegate - 맵 터치할 때 필요한 델리게이트
// CLLocationManagerDelegate - 위치 관련 필요한 델리게이트
final class MapCoordinator: NSObject, ObservableObject, NMFMapViewCameraDelegate, CLLocationManagerDelegate {
    static let shared = MapCoordinator()
    
    let view = NMFNaverMapView(frame: .zero)
    var markers: [NMFMarker] = []
    var locationManager: CLLocationManager?  // [위치 권한 사용 매니저]
    private let arrowheadPath = NMFArrowheadPath()
    
    @Published var currentShopId: String = ""
    @Published var isShowingMarkerDetailView: Bool = false
    @Published var userLocation: (Double, Double) = (0.0, 0.0)
    @Published var pathsBycar: [[Double]] = []
    @Published var isShowingPathLine: Bool = false
    @Published var isNavigationMapView: Bool = false
    
    override init() {
        super.init()
        
        // 위치 추적이 활성화되고, 현위치 오버레이와 카메라의 좌표가 사용자의 위치를 따라 움직인다.
        // API나 제스처를 사용해 임의로 카메라를 움직일 경우 모드가 NMFMyPositionNormal로 바뀐다.
        view.mapView.positionMode = .direction
        
        view.mapView.zoomLevel = 9     // 기본 카메라 줌 레벨
        view.mapView.minZoomLevel = 6  // 최소 줌 레벨
        view.mapView.maxZoomLevel = 17  // 최대 줌 레벨
        
        view.showLocationButton = true  // 현재 위치 버튼
        view.showZoomControls = true    // 줌 확대/축소 버튼 활성화
        view.showScaleBar = true        // 축적 바
        view.showCompass = false        // 나침반
        
        view.mapView.addCameraDelegate(delegate: self)
    }
    
    @objc func buttonTapped() {
        print("Button tapped")
        isShowingPathLine = false
        removePathLine()
    }
    
    func checkLocationServiceIsEnabled() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async {
                    self.locationManager = CLLocationManager()
                    self.locationManager!.delegate = self
                    self.checkLocationAuthorizationStatus()
                }
            } else {
                print("Show an alert letting them know this is off and to go turn i on")
            }
        }
    }
    
    /// 상태가 변경되기 전에  사용자의 위치 권한을 관리하고 위치 정보를 가져온다.
    func checkLocationAuthorizationStatus() {
        guard let locationManager = locationManager else { return }
        
        // 처음엔 notDetermined -> 한 번만 허용 -> break로 빠져 나옴
        // 항상허용해도 처음에는 네이버가 나옴 -> break되어서 그럼
        
        // locationManager의 권한 상태를 확인하기 위한 switch문
        switch locationManager.authorizationStatus {
        case .notDetermined:   // 위치 권한이 아직 결정되지 않는 경우, 사용자에게 위치 권한 요청을 보낸다.
            locationManager.requestWhenInUseAuthorization()
        case .restricted:  // 위치 정보 접근이 제한된 경우 메시지를 출력
            print("위치 정보 접근이 제한되었습니다.")
        case .denied:  // 위치 정보 접근이 거부된 경우, 메시지 출력 후 설정에서 권한을 변경하도록 안내 -> alert으로 보여줘야 함
            print("위치 정보 접근을 거절했습니다. 설정에 가서 변경하세요.")
        case .authorizedAlways, .authorizedWhenInUse:
            print("Success")
            fetchUserLocation()
            // 새로운 case가 추가되면
        @unknown default:
            break
        }
    }
    
    /// 위치 정보 권한 상태가 변경될 때 실행되는 함수
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            // 권한이 승인된 경우
            print("Success")
            // 추가 작업 수행
            fetchUserLocation()
        case .restricted:
            print("위치 정보 접근이 제한되었습니다.")
        case .denied:
            print("위치 정보 접근을 거절했습니다. 설정에서 변경하세요.")
        default:
            break
        }
    }
    
    /// 사용자 위치 가져오는 함수
    func fetchUserLocation() {
        
        if let locationManager = locationManager {
            let lat = locationManager.location?.coordinate.latitude
            let lng = locationManager.location?.coordinate.longitude
            userLocation = (Double(lat ?? 0.0), Double(lng ?? 0.0))
            
            // 카메라를 현위치로 이동
            // 여기서 nil 값이 들어감
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat ?? 0.0, lng: lng ?? 0.0), zoomTo: 13)
            cameraUpdate.animation = .easeIn
            cameraUpdate.animationDuration = 1
            
            // 현재 위치 좌표 overlay 마커 표시
            let locationOverlay = view.mapView.locationOverlay
            locationOverlay.location = NMGLatLng(lat: lat ?? 0.0, lng: lng ?? 0.0)
            locationOverlay.hidden = false
            
            // 내 주변 5km 반경 overlay 표시
            let circle = NMFCircleOverlay()
            circle.center = NMGLatLng(lat: lat ?? 0.0, lng: lng ?? 0.0)
            circle.radius = 5000
            circle.mapView = nil
            
            view.mapView.moveCamera(cameraUpdate)
            
        }
    }
    
    // MARK: - 위치 변경될 때 실행
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        fetchUserLocation()
    }
    
    // MARK: - 카메라 이동
    /// 카메라 이동 함수
    func moveCameraToUserLocation() {
        // NMFCameraUpdate는 카메라를 이동할 위치, 방법 등을 정의하는 클래스
        // scrollTo: 카메라의 대상 지점을 지정한 좌표로 변경
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: userLocation.0, lng: userLocation.1), zoomTo: 13)
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 1
        MapCoordinator.shared.view.mapView.moveCamera(cameraUpdate)
    }
    
    
    /// 검색한 위치로 카메라 이동
    /// - Parameter shopDatas: 검색으로 필터링된 ShopDatas
    func moveCameraToSearchLocation(filteredShopDatas: [ShopModel]) {
        var positions: [NMGLatLng] = []
        
        // NMGLatLng형태로 계산하기 위함
        for shopData in filteredShopDatas {
            let marker = NMFMarker()
            
            marker.position = NMGLatLng(lat: shopData.latitude, lng: shopData.longitude)
            positions.append(marker.position)
        }
        
        // 경계 상자 계산
        if let bounds = calculateBounds(positions: positions) {
            // 경계 상자에 맞춰 지도 확대 수준 조절
            view.mapView.moveCamera(NMFCameraUpdate(fit: bounds, padding: 100))
        }
    }
    
    // 경로에 맞게 카메라 포커싱
    func moveCameraToPathLocation(shopData: ShopModel) {
        var positions: [NMGLatLng] = []
        
        // 유저위치
        let userPosition = NMGLatLng(lat: userLocation.0, lng: userLocation.1)
        positions.append(userPosition)
        
        let shopPosition = NMGLatLng(lat: shopData.latitude, lng: shopData.longitude)
        positions.append(shopPosition)
                
        // 경계 상자 계산
        if let bounds = calculateBounds(positions: positions) {
            // 경계 상자에 맞춰 지도 확대 수준 조절
            view.mapView.moveCamera(NMFCameraUpdate(fit: bounds, padding: 100))
        }
    }
    
    
    /// 마커들의 중앙 좌표 얻기
    /// - Parameter positions: 필터링된 가게들의 위도, 경도 배열
    /// - Returns: 최소 경계 사각형 영역을 나타내는 클래스
    private func calculateBounds(positions: [NMGLatLng]) -> NMGLatLngBounds? {
        guard !positions.isEmpty else {
            return nil
        }
        
        var minLat = positions[0].lat
        var maxLat = positions[0].lat
        var minLng = positions[0].lng
        var maxLng = positions[0].lng
        
        for position in positions {
            let lat = position.lat
            let lng = position.lng
            
            minLat = min(minLat, lat)
            maxLat = max(maxLat, lat)
            minLng = min(minLng, lng)
            maxLng = max(maxLng, lng)
        }
        
        let southWest = NMGLatLng(lat: minLat, lng: minLng)
        let northEast = NMGLatLng(lat: maxLat, lng: maxLng)
        
        return NMGLatLngBounds(southWest: southWest, northEast: northEast)
    }
    
    // MARK: - 상점 위치에 마커 생성
    /// 지도에마커 생성 함수
    func makeMarkers(shopDatas: [ShopModel]) {
        
        for shopData in shopDatas {
            let marker = NMFMarker()
            
            marker.position = NMGLatLng(lat: shopData.latitude, lng: shopData.longitude)
            marker.captionRequestedWidth = 100
            marker.captionText = shopData.shopName
            marker.captionMinZoom = 10
            marker.captionMaxZoom = 17
            
            markers.append(marker)
        }
        // 지도에 오버레이 추가하기
        for marker in markers {
            marker.mapView = view.mapView
        }
        markerTapped()
    }
    
    
    /// 생성된 마커 지우기
    func removeMarkers() {
        while !markers.isEmpty {
            let removeMarker = markers.removeFirst()
            removeMarker.mapView = nil
        }
    }
    
    // MARK: - 마커 터치 시 이벤트
    // 마커 액션을 통해 시트 변수에 대한 값과 ShopModel에 해당하는 데이터를 넘겨야 함
    func markerTapped() {
        guard !isNavigationMapView else { return }
        for marker in markers {
            // touchHandler로 Marker 터치 관리
            marker.touchHandler = { [self] (overlay) -> Bool in
                let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: marker.position.lat, lng: marker.position.lng))
                cameraUpdate.animation = .fly
                cameraUpdate.animationDuration = 1
                self.view.mapView.moveCamera(cameraUpdate)
                self.isShowingMarkerDetailView = true
                self.currentShopId = marker.captionText
                print(currentShopId)
                return true
            }
            marker.mapView = view.mapView
        }
    }
    
    // MARK: - 현재 위치 좌표 거리 계산 함수
    func distancePresentToDestination(_ lat: Double, _ log: Double) -> String {
        
        if userLocation == (0.0, 0.0) {
            return "-"
        }
        
        let from = CLLocation(latitude: lat, longitude: log)
        
        let to = CLLocation(latitude: userLocation.0 , longitude: userLocation.1)
        let distance = from.distance(from: to) / 1000
        let distanceString = String(format: "%.2f", distance)
        
        return distanceString
    }
    
    func makePathLine() {
        var latLngArray: [NMGLatLng] = []
        
        for pathByCar in pathsBycar {
            if pathByCar.count == 2 {
                let lng = pathByCar[0]
                let lat = pathByCar[1]
                let latLng = NMGLatLng(lat: lat, lng: lng)
                
                latLngArray.append(latLng)
            }
        }
        arrowheadPath.points = latLngArray
        arrowheadPath.color = UIColor.blue
        arrowheadPath.mapView = view.mapView
        
        isShowingPathLine = true
    }
    
    func removePathLine() {
        arrowheadPath.mapView = nil
        MapCoordinator.shared.isShowingPathLine = false
    }
}
