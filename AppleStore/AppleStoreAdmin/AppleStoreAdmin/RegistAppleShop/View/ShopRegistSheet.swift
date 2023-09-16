//
//  ShopRegistSheet.swift
//  AppleStoreAdmin
//
//  Created by 송성욱 on 2023/09/07.
//

import SwiftUI
// MARK: - AppleStore 등록 뷰
struct ShopRegistSheet: View {
    
    var appleShop: ShopModel
    @ObservedObject var appleShopStore: ShopDataStore = ShopDataStore()
    @State var shopName: String = "" //ok
    @State var city: String = ""
    @State var imageURLString: String = "" //ok
    @State var address: String = ""
    @State var detailedAddress: String = ""
    @State var latitude: String = ""
    ///String 값을 Double 값으로 변환시켜주는 연산 프로퍼티
    var doublelat: Double {
        get {
            return Double(latitude) ?? 0.0
        }
    }
    var doublelong: Double {
        get {
            return Double(longitude) ?? 0.0
        }
    }
    @State var longitude: String = ""
    @State var phoneNumber: String = ""
    ///시간 등록처리를 어떻게 하면 좋을지 고민중입니다.
    @State var hours: [String] = Array(repeating: "10:00 오전 - 10:00 오후", count: 7)
    @State var postCode: String = ""
    @State var shopInformation: String = ""
    @Binding var isShowingSheet: Bool
    
    var body: some View {
        VStack {
            MapView(appleShop: appleShop)
                .frame(height: 300)
            
            ///TextField가 다 기입이 되지 않으면 등록버튼이 나오지 않음.
            
            VStack {
                if !shopName.isEmpty && !imageURLString.isEmpty && !city.isEmpty && !address.isEmpty && !detailedAddress.isEmpty && !postCode.isEmpty && !latitude.isEmpty && !longitude.isEmpty && !phoneNumber.isEmpty && !shopInformation.isEmpty {
                    Button {
                    
                        appleShopStore.addShop(id: appleShop.id, shopName: shopName, city: city, imageURLString: imageURLString, address: address, detailedAddress: detailedAddress, latitude: doublelat, longitude: doublelong, phoneNumber: phoneNumber, hours: hours, postCode: postCode, shopInformation: shopInformation)
                        appleShopStore.fetchData()
                        isShowingSheet = false
                    } label: {
                        Text("등록하기")
                            .foregroundColor(.blue)
                            .padding(.bottom, 10)
                    }
                } else {
                    Text("등록하려면 시트를 작성해주세요.")
                        .padding(.bottom, 10)
                }
            }
            
            List {
                Section("스토어 이름") {
                    TextField(text: $shopName) {
                        Text("스토어 이름을 입력하세요.")
                    }
                    .disableAutocorrection(false)
                }
                Section("스토어 사진 URL") {
                    TextField(text: $imageURLString) {
                        Text("스토어 사진 URL을 입력하세요.")
                    }
                }
                Section("스토어 주소 / 세부 주소") {
                    TextField(text: $city) {
                        Text("스토어가 위치한 도시를 입력하세요.")
                    }
                    TextField(text: $address) {
                        Text("스토어 주소를 입력하세요.")
                    }
                    TextField(text: $detailedAddress) {
                        Text("스토어 세부 주소를 입력하세요.")
                    }
                    TextField(text: $postCode) {
                        Text("스토어 우편번호를 입력하세요.")
                    }
                    .keyboardType(.numberPad)
                }
                Section("스토어 위치") {
                    TextField(text: $latitude) {
                        Text("위도 값을 입력하세요.")
                    }
                    .keyboardType(.numberPad)
                    TextField(text: $longitude) {
                        Text("경도 값을 입력하세요.")
                    }
                    .keyboardType(.numberPad)
                }
                Section("스토어 전화번호") {
                    TextField(text: $phoneNumber) {
                        Text("스토어 전화번호를 입력하세요.")
                    }
                }
                Section("스토어 설명") {
                    TextField(text: $shopInformation) {
                        Text("스토어 설명을 입력하세요.")
                    }
                }
            }
            .padding()
            .padding(.bottom, 20)
  
            
        }
        .listStyle(.plain)
        .edgesIgnoringSafeArea(.all)
        .hideKeyboardOnTap()

    }
        
}

struct ShopRegistSheet_Previews: PreviewProvider {
    static var previews: some View {
        ShopRegistSheet(appleShop: ShopDataStore().sampleData, isShowingSheet: .constant(true))
        
    }
}
