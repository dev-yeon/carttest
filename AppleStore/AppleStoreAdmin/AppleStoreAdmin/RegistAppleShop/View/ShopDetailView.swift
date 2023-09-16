//
//  ShopDetailView.swift
//  AppleStoreAdmin
//
//  Created by 송성욱 on 2023/09/11.
//

import SwiftUI
import Kingfisher

// MARK: -  AppleStore 상세정보 뷰
struct ShopDetailView: View {
    
    let appleShop: ShopModel
    
    @ObservedObject var appleShopStore: ShopDataStore = ShopDataStore()
    let dayOfTheWeek: [String] = ["월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"]

    @State var isShowingSheet: Bool = false
    
    var body: some View {
        VStack {
            KFImage(URL(string: appleShop.imageURLString))
                .placeholder({ _ in
                    ProgressView()
                        .foregroundColor(.gray)
                    
                }).retry(maxCount: 3, interval: .seconds(5))
                .cancelOnDisappear(true) //셀이 화면에서 안보일때는 로드하지 않음.
                .resizable()
                .frame(height: 320)
                .aspectRatio(contentMode: .fit)
                
     
            List {
                Section("매장명") {
                    Text(appleShop.shopName)
                }
                Section("주소 / 우편번호") {
                    Text("\(appleShop.address) \(appleShop.detailedAddress)")
                    Text(appleShop.postCode)
                }
                Section("전화번호") {
                    Text(appleShop.phoneNumber)
                }
               
                Section("설명") {
                    Text(appleShop.shopInformation)
                }
                
                Section("영업시간") {
                    HStack {
                        VStack {
                            ForEach(dayOfTheWeek, id: \.self) { day in
                                Text(day)
                                    .padding(.bottom)
                            }
                        }
                        VStack {
                            ForEach(appleShop.hours, id: \.self) { hour in
                                Text(hour)
                                    .padding(.bottom)
                            }
                        }
                        
                    }

                }
                
                Section("위치") {
                    Button {
                        isShowingSheet = true
                    } label: {
                        Text("지도보기")
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding(.horizontal)
            .listStyle(.plain)
            .font(.title2)
            .sheet(isPresented: $isShowingSheet) {
                MapView(appleShop: appleShop)
            }
            
        }
        .edgesIgnoringSafeArea(.top)
    }
}



struct ShopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ShopDetailView(appleShop: ShopDataStore().sampleData)

    }
}
