//
//  ShopDetailView.swift
//  AppleStore
//
//  Created by 박성훈 on 2023/09/06.
//

import SwiftUI
import Kingfisher

enum WeekDays: String, CaseIterable {
    case monday = "월요일"
    case tuesday = "화요일"
    case wednesday = "수요일"
    case thursday = "목요일"
    case friday = "금요일"
    case saturday = "토요일"
    case sunday = "일요일"
}

enum KeyLoadingError: Error {
    case fileNotFound
    case keyNotFound
}

struct ShopDetailView: View {
    let shopData: ShopModel
    
    @ObservedObject var shopDataStore: ShopDataStore
    @State private var isShowCallingSheet: Bool = false  // 전화 액션시트
    @State private var distanceByCar: String = "-"
    @State private var durationByCar: String = "-"
    private let bundle = Bundle()
    let isNavigated: Bool
    
    private var imageURL: URL? {
        URL(string: shopData.imageURLString)
    }
    
    var body: some View {
        if MapCoordinator.shared.isShowingMarkerDetailView {
            // marker 터치했을 때 sheet
            NavigationStack {
                makeDetailView()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                MapCoordinator.shared.isShowingMarkerDetailView.toggle()
                            } label: {
                                Text("취소")
                                    .foregroundColor(.red)
                                    .padding(.trailing, 5)
                            }
                            
                        }
                    }
            }
        } else {
            // ShopListView에서 넘어갈 때
            makeDetailView()
        }
    }
    
    func makeDetailView() -> some View {
        ScrollView {
            KFImage(imageURL)
                .placeholder {
                    Rectangle()
                        .foregroundColor(.secondary)
                        .frame(height: 220)
                        .aspectRatio(contentMode: .fit)
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Apple \(shopData.shopName)")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 1)
                
                Group {
                    Text("닫는시간: 오후 10:00")
                        .padding(.bottom)
                    
                    Text("차량 이동거리: \(distanceByCar) km")
                        .padding(.bottom, 5)
                    Text("차량 이동시간: \(durationByCar)")
                        .padding(.bottom, 5)
                    
                    if MapCoordinator.shared.isShowingMarkerDetailView {
                        Button("경로 보기") {
                            MapCoordinator.shared.isShowingMarkerDetailView = false
                            MapCoordinator.shared.makePathLine()
                            
                            //유저의 위치에서 가게로 가는 경로로 카메라 이동
                            MapCoordinator.shared.removeMarkers()
                            MapCoordinator.shared.makeMarkers(shopDatas: [shopData])
                            MapCoordinator.shared.moveCameraToPathLocation(shopData: shopData)
                        }
                    } else {
                        NavigationLink {
                            NaverMap()
                                .onAppear {
                                    MapCoordinator.shared.makePathLine()
                                    if isNavigated {
                                        MapCoordinator.shared.isNavigationMapView = true
                                        
                                        //유저의 위치에서 가게로 가는 경로로 카메라 이동
                                        MapCoordinator.shared.removeMarkers()
                                        MapCoordinator.shared.makeMarkers(shopDatas: [shopData])
                                        MapCoordinator.shared.moveCameraToPathLocation(shopData: shopData)
                                    }
                                }
                                .onDisappear {
                                    MapCoordinator.shared.isNavigationMapView = false
                                }
                        } label: {
                            Text("경로 보기")
                        }
                    }
                    
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("픽업 방법")
                        .bold()
                        .padding(.bottom, 1)
                    Text("주문하신 제품이 준비되면 자세한 픽업 안내를 이메일로 보내드립니다. 새 기기 설정과 관련하여 도움이 필요하시면 Apple 스페셜리스트가 진행하는 무료 온라인 세션을 예약하세요.")
                        .padding(.bottom)
                    
                    Text("매장 내")
                        .padding(.bottom, 1)
                    Text("온라인으로 주문하신 제품을 픽업하세요. 기기 설정과 관련한 도움을 받고, 액세서리도 쇼핑하실 수 있습니다.")
                        .padding(.bottom, 12)
                    
                    Link(destination: URL(string: "https://www.apple.com/kr/shop/shipping-pickup")!) {
                        HStack {
                            Text("배송 및 픽업에 대해 더 알아보기")
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                        }
                        .font(.subheadline)
                    }
                }
                .padding(.vertical)
                
                Divider()
                
                VStack(alignment: .leading) {
                    Divider()
                        .opacity(0)
                    Text("영업시간")
                        .bold()
                    
                    ForEach(shopData.hours.indices, id: \.self) { index in
                        
                        HStack {
                            Text("\(WeekDays.allCases[index].rawValue)")
                            Spacer()
                            Text(shopData.hours[index])
                        }
                        .padding(.trailing)
                    }
                    .padding(.vertical, 3)
                }
                .padding(.vertical)
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("주소")
                        .bold()
                        .padding(.bottom, 3)
                    VStack(alignment: .leading) {
                        Divider()
                            .opacity(0)
                        Text(shopData.address)
                        
                        if shopData.detailedAddress != "" {
                            Text(shopData.detailedAddress)
                        }
                        Text(shopData.postCode)
                            .padding(.bottom, 8)
                    }
                    .font(.subheadline)
                    Text("\(MapCoordinator.shared.distancePresentToDestination(shopData.latitude, shopData.longitude)) km")
                        .foregroundColor(.secondary)
                        .font(.caption)
                    
                }
                .padding(.vertical)
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("전화")
                        .bold()
                        .padding(.bottom, 3)
                    
                    Button {
                        isShowCallingSheet.toggle()
                    } label: {
                        Text(shopData.phoneNumber)
                    }
                    .confirmationDialog("매장 전화번호", isPresented: $isShowCallingSheet) {
                        Button {
                            if let url = URL(string: "tel://\(shopData.phoneNumber)") {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            } else { print("전화 실패") }
                        } label: {
                            Label("통화 \(shopData.phoneNumber)", systemImage: "phone.fill")
                        }
                        Button("취소", role: .cancel) { }
                    }
                }
                .padding(.vertical)
                
            }
            .padding()
            .padding(.horizontal, 6)
            
        }
        .navigationTitle("스토어 세부사항")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            fetchDirectionAndDuration(goalLongitude: String(shopData.longitude), goalLatitude: String(shopData.latitude))
        }
        .onDisappear {
            MapCoordinator.shared.isNavigationMapView = false
        }
    }
    
    func fetchDirectionAndDuration(goalLongitude: String, goalLatitude: String) {
        
        let urlString = "https://naveropenapi.apigw.ntruss.com/map-direction-15/v1/driving?start=\(MapCoordinator.shared.userLocation.1),\(MapCoordinator.shared.userLocation.0)&goal=\(goalLongitude),\(goalLatitude)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let naverClientKey = try openNaverKey(forKey: "NMFClientId")
            let naverClientSecretKey = try openNaverKey(forKey: "NMFClientSecret")
            
            request.addValue(naverClientKey, forHTTPHeaderField: "X-NCP-APIGW-API-KEY-ID")
            request.addValue(naverClientSecretKey, forHTTPHeaderField: "X-NCP-APIGW-API-KEY")
        } catch KeyLoadingError.fileNotFound {
            print("'SecretKeys.plist를 찾을 수 없습니다.")
        } catch KeyLoadingError.keyNotFound {
            print("Key를 찾을 수 없습니다.")
        } catch {
            print(error)
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data {
                do {
                    let directionResponse = try JSONDecoder().decode(DirectionResponse.self, from: data)
                    
                    let distanceDouble = Double(directionResponse.route.traoptimal[0].summary.distance) / 1000
                    self.distanceByCar = String(format: "%.2f", distanceDouble)
                    self.durationByCar = formatDuration(seconds: directionResponse.route.traoptimal[0].summary.duration / 1000)
                    DispatchQueue.main.async {
                        MapCoordinator.shared.pathsBycar = directionResponse.route.traoptimal[0].path
                    }
                } catch {
                    print("docode error: \(error)")
                }
            }
        }
        .resume()
    }
    
    func formatDuration(seconds: Int) -> String {
        let minutes = seconds / 60
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        
        return "\(hours)시간 \(remainingMinutes)분"
    }
    
    func openNaverKey(forKey: String) throws -> String {
        guard let filePath = Bundle.main.path(forResource: "SecretKeys", ofType: "plist") else {
            throw KeyLoadingError.fileNotFound
        }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        
        guard let key = plist?.object(forKey: forKey) as? String else {
            throw KeyLoadingError.keyNotFound
        }
        
        return key
    }
}



struct ShopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ShopDetailView(shopData: ShopDataStore().shopDatas[0], shopDataStore: ShopDataStore(), isNavigated: true)
        }
    }
}
