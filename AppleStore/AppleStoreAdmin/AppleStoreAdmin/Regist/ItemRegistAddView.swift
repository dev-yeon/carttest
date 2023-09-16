//
//  ItemRegistAddView.swift
//  AppleStoreAdmin
//
//  Created by woojin Shin on 2023/09/05.
//

import SwiftUI
import AppleStoreCore


struct SubItemView<Content>: View where Content: View {
    
    let titleText: String
    var ispicker: Bool = true
    @Binding var bindData: String
    @ViewBuilder let pickerData: () -> Content
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(titleText)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 7)
                .padding(10)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(hex: "E4E4D0"))
                        .shadow(radius: 5)
                }
            Group {
                if ispicker {
                    Picker(titleText, selection: $bindData){
                        pickerData()
                    }
                    .labelsHidden()
                    
                } else {
                    pickerData()
                }
            }
            .tint(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height:15)
            .padding(10)
            
        }
        .padding(3)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 0.5)
        }
        
    }
    
}


//MARK: - 메인 뷰
/// 제품정보 등록View
struct ItemRegistAddView: View {
    @StateObject var model: ItemViewModel
    
    ///ItemRegistEditView에서 List와 같이사용되는지 or 단독적으로 사용하는지 구분
    var isSingle: Bool = true   //기본값 true
    
    @State private var itemType: String = ""
    @State private var mainImageString: String = ""
    @State private var seriesName: String = ""
    @State private var productName: String = ""
    @State private var description: String = ""
    @State private var productColor: String = "#FFFFFF"
    @State private var storage: String = ""
    @State private var price: String = ""
    @State private var status: String = "3"
    //    @State private var inch: String = ""
    @State private var embedCellular: String = ""
    
    @State private var isToggleOn = false
    @State private var isImageTouch = false
    @State private var isDeleteTouch = false
    @State private var isRecieved = false
    @State private var isWeb = false
    @State private var isColorPickerSelect = false
    
    @State private var toast: Toast? = nil  //토스트메시지뷰
    
    private var webURL: String {
        if itemType == ItemType.iphone.rawValue {
            return "https://www.apple.com/kr/iphone/"
        } else {
            return "https://www.apple.com/kr/ipad-select/"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack(alignment: .center, spacing: 15) {

                ImageURLView(imageURL: $mainImageString)
                    .onTapGesture {
                        if mainImageString != "" {
                            isImageTouch.toggle()
                            
                        }
                    }
                    .sheet(isPresented: $isImageTouch) {
                        ImageURLView(imageURL: $mainImageString)
                    }
                
                VStack(spacing: 10) {
                    HStack {
                        if isSingle {
                            Toggle(isOn: $isToggleOn) {
                                Text("등록 후 초기화")
                            }
                            .frame(width: 160)
                        }
                        
                        Button {
                            if isSingle {
                                print("등록버튼 눌림")
                                registData()
                            } else {
                                updateData()
                            }
                        } label: {
                            Text(isSingle ? "등록" : "수정")
                                .font(.title3)
                                .bold()
                                .frame(maxWidth: .infinity)
                                .modifier(registButtonDesign(fillColor: Color(hex: "344CB7")))
                            
                        }
                        
                        Button {
                            if !productName.isEmpty {
                                isDeleteTouch.toggle()
                            }
                            
                        } label: {
                            Text("삭제")
                                .font(.title3)
                                .bold()
                                .frame(maxWidth: .infinity)
                                .modifier(registButtonDesign(fillColor: Color(hex: "CD0A0A")))
                        }
                    }
                    
                    Spacer().frame(height: 10)
                    
                    Text(" * 은 필수입력")
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.gray)
                    

                    HStack(spacing: 10) {
                        Text("*제품명")
                            .padding(10)
                            .frame(width: 110, alignment: .trailing)

                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(CustomColor.mainColor)
                            }
                        
                        TextField("입력해주세요", text: $productName)
                            .textInputAutocapitalization(.none)
                        
                        
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(CustomColor.mainColor, lineWidth: 2)
                        
                    }
                    
                    HStack(spacing: 10) {
                        Text("부가설명")
                            .padding(10)
                            .frame(width: 110, alignment: .trailing)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(CustomColor.mainColor)
                            }
                        
                        TextField("ex) Liquid Retina 디스플레이", text: $description)
                            .textInputAutocapitalization(.none)
                        
                        
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(CustomColor.mainColor, lineWidth: 2)
                        
                    }
                    
                    HStack(spacing: 10){
                        Text("*가격")
                            .padding(10)
                            .frame(width: 110, alignment: .trailing)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(CustomColor.mainColor)
                            }
                        
                        TextField("0", text: $price)
                            .keyboardType(.numberPad)
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(CustomColor.mainColor, lineWidth: 2)
                        
                    }
                    
                    
                    HStack(spacing: 10) {
                        Text("*이미지URL")
//                            .font(.body)
                            .padding(10)
                            .frame(width: 110, alignment: .trailing)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(CustomColor.mainColor)
                            }
                        
                        TextField("입력해주세요", text: $mainImageString)
                        
                        Button {
                            mainImageString = ""
                        } label: {
                            if !mainImageString.isEmpty {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal, 10)
                        
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(CustomColor.mainColor, lineWidth: 2)
                        
                    }
                    
                    
                    Button {
                        isWeb.toggle()
                    } label: {
                        Text("직접 선택하기")
                    }
                    .sheet(isPresented: $isWeb) {
                        ImageWebView(url: URL(string: webURL)!)
                            
                    }
                    
                    Spacer()
                    
                    
                }
                .frame(maxHeight: .infinity)
                .contentShape(Rectangle())
                .hideKeyboardOnTap()
                .alert("정말 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.", isPresented: $isDeleteTouch) {
                    Button("예", role: .destructive) { deleteData() }
                    Button("취소", role: .cancel) { print("삭제 취소") }
                }
                
                
                
            }
            .overlay {
                Rectangle()
                    .fill(.clear)
                    .toastView(toast: $toast)
            }
            
            ScrollView {
                VStack(spacing: 12) {
                    HStack(alignment: .center, spacing: 15) {
                        SubItemView(titleText: "제품타입", bindData: $itemType) {
                            ForEach(ItemType.allCases) { index in
                                Text("\(index.rawValue)")
                                    .tag(index.rawValue)
                                
                            }
                        }
                        .disabled(isSingle ? false : true)
                        
                        
                        
                        SubItemView(titleText: "Series", bindData: $seriesName) {
                            ForEach(model.kind.series ?? [], id: \.self) { index in
                                Text("\(index)")
                                    .tag(index)
                                
                            }
                        }
                        
                    }
                    
                    HStack(spacing: 15) {
                        //MARK: - 색상
                        SubItemView(titleText: "색상", ispicker: false, bindData: $productColor) {
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(hex: productColor.getNameColor[1]))
                                    Text(productColor.getNameColor[0])
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal, 10)
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                isColorPickerSelect = true
                            }
                            
                        }
                        .sheet( isPresented: $isColorPickerSelect) {
                            VStack {
                                Spacer().frame(height: 10)
                                
                                ScrollView {
                                    ForEach(model.kind.colors ?? [], id: \.self) { index in
                                        Button {
                                            isColorPickerSelect = false
                                            productColor = index
                                        } label: {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color(hex: index.getNameColor[1]))
                                                Text(index.getNameColor[0])
                                                    .foregroundColor(.white)
                                            }
                                            .frame(height: 50)
                                            .padding(.horizontal, 10)
                                        }
                                    }
                                    Spacer()
                                }
                            }
                        }
                        
                        SubItemView(titleText: "저장용량", bindData: $storage) {
                            ForEach(model.kind.storages ?? [], id: \.self) { index in
                                Text("\(index)")
                                    .tag(index)
                                
                            }
                        }
                    }
                    
                    
                    HStack(alignment: .center, spacing: 15) {
                        //우선 제품타입은 아이폰, 아이패드 두가지만 생각하기로...
                        if itemType == ItemType.ipad.rawValue {
                            SubItemView(titleText: "모델", bindData: $embedCellular) {
                                ForEach(model.kind.embedCellulars ?? [], id: \.self) { index in
                                    Text("\(index)")
                                        .tag(index)
                                    
                                }
                            }
                            
                        }
                        
                        SubItemView(titleText: "상태", bindData: $status) {
                            ForEach(Status.allCases) { index in
                                Text("\(index.displayName)")
                                    .tag("\(index.rawValue)")
                                
                            }
                        }
                    }
                    
                }
            }
            .hideKeyboardOnTap()
            .refreshable {
                fetchKindData { }
            }
            
        }
        .padding()
        .onChange(of: itemType) { changeValue in
            //iphone에서 ipad로 변경할때 값이 변경되면서 onChange 실행됨
            print("onChange  \(changeValue),  \(isSingle)")
            fetchKindData {
                if !isSingle {
                    fetchItemInfoDataRecieve()
                }
            }
            
        }
        .onReceive(model.$chgViewType) { type in
            //Receive건이 있을 경우 onAppear보다 먼저 실행됨...
//            print("onReceieve, \(isSingle)")
            if isSingle {
                if type != .list {
                    self.itemType = ItemType.iphone.rawValue
                    fetchKindData { }
                }
            } else {
                fetchItemInfoDataRecieve()
            }
            
        }
        
    }
    
    ///카테고리 데이터 가져오기
    private func fetchKindData(completion: @escaping () -> Void) {
        //        print("itemType: \(itemType)")
        //View에 영향을 주는 구문이기때문에 메인쓰레드에서 실행 (안그러면 포도맛)
        DispatchQueue.main.async {
            
            print("fethKindData")
            
            model.fetchKind(docID: itemType) { kind in
                self.seriesName = kind.series?.isEmpty == true ? "" : kind.series?[0] ?? ""
                self.productColor = kind.colors?.isEmpty == true ? "" : kind.colors?[0] ?? "#FFFFFF"
                self.storage = kind.storages?.isEmpty == true ? "" : kind.storages?[0] ?? ""
                self.embedCellular = kind.embedCellulars?.isEmpty == true ? "" : kind.embedCellulars?[0] ?? ""

                completion()
            }
        }
    }
    
    
    private func fetchItemInfoDataRecieve() {
        self.itemType = model.itemInfo.itemType
        
        self.mainImageString = model.itemInfo.mainImageString
        self.seriesName = model.itemInfo.seriesName
        self.productName = model.itemInfo.productName
        self.description = model.itemInfo.description
        self.productColor = model.itemInfo.productColor
        self.storage = model.itemInfo.storage
        self.price = model.itemInfo.price
        self.status = String(model.itemInfo.status)
        //        self.inch = model.itemInfo.inchModel
        
        self.embedCellular = model.itemInfo.embedCellular ?? ""
    }
    
    
    ///제품정보 등록
    private func registData() {
        model.itemInfo = ItemInfo(itemType: itemType,
                                  seriesName: seriesName,
                                  productName: productName,
                                  description: description,
                                  price: price,
                                  mainImageString: mainImageString,
                                  productColor: productColor,
                                  storage: storage,
                                  status: Int(status) ?? 3,
                                  embedCellular: embedCellular)
        
        let docID = model.itemInfo.id
        
        //필드 공백 체크
        var checkInfo: (ItemViewModel.RegistStatus, String)
        
        //        print("rawValue : \(itemType),  \(ItemType.iphone.rawValue)")
        if itemType == ItemType.iphone.rawValue {
            checkInfo = model.itemFieldCheck(exceptFields: ["embedCellular","description"])
        } else {
            checkInfo = model.itemFieldCheck(exceptFields: ["description"])
        }
        
        
        if checkInfo.0 == .emptyField {
            toast = .init(style: .warning, message: "\(checkInfo.1.convertColName)의 값이 입력되지 않았습니다.\n입력후 재시도 바랍니다.", width: 300)
            
            return
            
        } else {
            model.addItemInfo(docID: docID) { result in
                if result {
                    toast = .init(style: .success, message: "등록되었습니다.", width: 150)
                } else {
                    toast = .init(style: .error, message: "등록중 오류가 발생하였습니다.", width: 200)
                }
            }
        }
        
        //등록 후 초기화
        if isToggleOn {
            self.itemType = ""
            self.mainImageString = ""
            self.seriesName = ""
            self.productName = ""
            self.description = ""
            self.productColor = "#FFFFFF"
            self.storage = ""
            self.price = ""
            self.status = "3"
            //            self.inch = ""
            self.embedCellular = ""
            
            model.chgViewType = .add
        }
        
    }
    
    ///제품정보 삭제
    private func deleteData() {
        let docID = model.itemInfo.id
        
        model.deleteItemInfo(docID: docID) {
            if $0 {
                toast = .init(style: .success, message: "삭제되었습니다.", width: 150)
                
                model.chgViewType = .list
                
                //삭제 후 초기화
                self.itemType = ""
                self.mainImageString = ""
                self.seriesName = ""
                self.productName = ""
                self.description = ""
                self.productColor = "#FFFFFF"
                self.storage = ""
                self.price = ""
                self.status = "3"
                //        self.inch = ""
                self.embedCellular = ""
                
                model.itemInfo.productName = "" //
            }
        }
        
    }
    
    
    ///제품정보 수정
    private func updateData() {
        var tempData = model.itemInfo
        
        let docID = tempData.id
        
        tempData.seriesName = seriesName
        tempData.productName = productName
        tempData.description = description
        tempData.price = price
        tempData.mainImageString = mainImageString
        tempData.productColor = productColor
        tempData.storage = storage
        tempData.status = Int(status) ?? 3
        tempData.embedCellular = embedCellular
        
        model.itemInfo = tempData
        
        var checkInfo: (ItemViewModel.RegistStatus, String)
        if itemType == ItemType.iphone.rawValue {
            checkInfo = model.itemFieldCheck(exceptFields: ["embedCellular"])
            
        } else {
            checkInfo = model.itemFieldCheck()
        }
        
        if checkInfo.0 == .emptyField {
            toast = .init(style: .warning, message: "\(checkInfo.1.convertColName)의 값이 입력되지 않았습니다.\n입력후 재시도 바랍니다.", width: 300)
            return
            
        } else {
            //수정 메서드
            model.updateItemInfo(docID: docID) { result in
                
                if result {
                    model.chgViewType = .list
                    toast = .init(style: .success, message: "수정되었습니다.", width: 150)
                } else {
                    toast = .init(style: .error, message: "수정중 오류가 발생하였습니다.", width: 200)
                }
            }
        }
        
    }
    
}

extension ItemRegistAddView {
    private enum CustomColor {
        static let mainColor: Color = Color(hex: "E4E4D0")
    }
}




struct ItemRegistAddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ItemRegistAddView(model: ItemViewModel())
            
        }
    }
}
