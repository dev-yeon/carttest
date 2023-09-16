//
//  AddressSettingView.swift
//  AppleStore
//
//  Created by dayexx on 2023/09/05.
//

import SwiftUI
import MapKit

struct AddressSettingView: View {
    
    @ObservedObject var myInfoStore: MyInfoStore
    
    @State var selectedAddrress: String = ""
    @State var selectedPostal: String = ""
    @State private var searchText = ""
    @State private var mapItems: [MKMapItem] = []
    @State private var isShowingResultView: Bool = false
    @State private var isShowingAlert: Bool = false
    @Binding var isShowingAddressSheet: Bool
    
    var body: some View {
        VStack{
            //검색창
            HStack{
                Image(systemName: "magnifyingglass").padding().foregroundColor(.gray)
                TextField("도로명 주소를 입력하세요.", text: $searchText)
                    .keyboardType(.default)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .foregroundColor(.black)
                    .onSubmit{
                        search()
                    }
                    .onTapGesture{
                        isShowingResultView = true
                    }
            }
            .frame(height:50)
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(10)
            .padding()
            
            ZStack{
                //주소, 도로명 서치
                if(isShowingResultView){
                    List(mapItems, id: \.self) { mapItem in //위 OnSubmit에서 서치한 배열 결과들 List로 보여줌
                        VStack(alignment: .leading) {
                            Text(mapItem.name ?? "").font(.headline)
                            Text(mapItem.placemark.title ?? "").font(.subheadline)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onTapGesture { //결과 선택하면 주소와, 우편번호 저장 후 뷰 닫아줌
                            searchText = ""
                            myInfoStore.myInfo.headAddress = mapItem.placemark.title ?? ""
                            myInfoStore.myInfo.postal = mapItem.placemark.postalCode ?? ""
                            isShowingResultView = false
                        }
                    }.listStyle(.plain)
                }
                else {
                    //폼 화면
                    List{
                        customTextField(tag: "이름", text: $myInfoStore.myInfo.userName).disabled(true)
                        customTextField(tag: "우편번호", text: $myInfoStore.myInfo.postal)
                        customTextField(tag: "주소", text: $myInfoStore.myInfo.headAddress)
                        customTextField(tag: "상세주소", text: $myInfoStore.myInfo.detailAddress)
                        customTextField(tag: "국가", text: $myInfoStore.myInfo.nation)
                        customTextField(tag: "핸드폰", text: $myInfoStore.myInfo.phone)
                    }
                    .navigationTitle("주소")
                    .navigationBarTitleDisplayMode(.inline)
                    .listStyle(.plain)
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                isShowingAddressSheet = false
                            } label: {
                                Text("취소")
                            }.foregroundColor(.blue)
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                Task {
                                    await myInfoStore.saveAddress(myInfoStore.myInfo)
                                }
                                isShowingAlert.toggle()
                            } label: {
                                Text("저장")
                            }.foregroundColor(.blue)
                        }
                    }
                    .alert(isPresented: $isShowingAlert) {
                        Alert(
                            title: Text("저장"),
                            message: Text("주소를 저장하시겠습니까?"),
                            primaryButton:
                                    .default(Text("확인")) {
                                        isShowingAddressSheet = false
                                    },
                            secondaryButton:
                                    .cancel(Text("취소"))
                        )
                    }
                }
            }
//            .onTapGesture {
//                if(isShowingResultView){isShowingResultView = false}
//            }
        }
    }
    
    func customTextField(tag: String, text: Binding<String> ) -> some View {
        HStack(){
            Text(tag).frame(width:100, alignment: .leading).bold()
            if tag == "주소" {
                TextEditor(text: text)
                    .frame(minHeight: 50)
            }
            else if tag == "우편번호" {
                TextField("", text: text)
                    .keyboardType(.numberPad)
            }
            else if tag == "핸드폰" {
                TextField("", text: text)
                    .keyboardType(.numberPad)
            }
            else {
                TextField("", text: text)
            }
        }.padding()
    }
    
    func customTextField(tag: String, text: Binding<String?>) -> some View {
        customTextField(tag: tag, text: Binding(get: {
            text.wrappedValue ?? ""
        }, set: { newValue in
            text.wrappedValue = newValue
        }))
    }
    
    private func search() { //주소 서치 요청
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText //검색어로 쿼리 요청
        
        let search = MKLocalSearch(request: request) //서치한것 받아옴
        search.start { response, error in //에러처리
            guard let response = response else {
                print("Error searching for places: \(error?.localizedDescription ?? "")")
                return
            }
            mapItems = response.mapItems //결과 배열에 넣어줌
        }
    }
}

/*
struct AddressSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            AddressSettingView(isShowingAddressSheet: .constant(true) )
        }
    }
}*/
