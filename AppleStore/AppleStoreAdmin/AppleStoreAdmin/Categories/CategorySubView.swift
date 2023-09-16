//
//  CategorySubView.swift
//  AppleStoreAdmin
//
//  Created by woojin Shin on 2023/09/07.
//

import SwiftUI
import AppleStoreCore

struct CategorySubView: View {
    let titleName: Types
    let itemType: ItemType
    @State private var name: String = ""
    @State private var placeholoderName: String = "입력"
    @StateObject var model: CategoryModel
    
    @State private var multiSelection = Set<UUID>()
    @State private var isEditing = false
    
    @State private var selectColor: Color = .accentColor
    @State private var toast: Toast? = nil  //토스트메시지뷰

    @State private var pickColor: String = ""
    
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 15) {
               
                Text(titleName.rawValue)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .frame(alignment: .leading)
                    .multilineTextAlignment(.center)
                    .padding(.leading, 7)
                    
                
                TextField(placeholoderName, text: $name)
                    .focused($isTextFieldFocused)
                    .padding()
                    .font(.system(size: 16))
                    .tint(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.white)
                            .frame(height: 40)
                    }
                    .onTapGesture {
                        isTextFieldFocused = true
                    }
                    .onChange(of: name) { newValue in
                        if titleName == .color && pickColor.isEmpty {
                            name = ""
                        }
                    }

                if titleName == .color {
                    ColorPicker("", selection: $selectColor, supportsOpacity: true)
                        .frame(width: 30)
                        .onChange(of: selectColor) { newValue in
                            pickColor = newValue.toHex()
                            placeholoderName = "색상명 입력"
                        }
                }
                
                
                Button {
                    registData()
                } label: {
                    Text("등록")
                }
                .modifier(registButtonDesign(fillColor: CustomColor.registButton))
        
                
                Button {
                    isEditing.toggle()
                } label: {
                    Text( isEditing ? "완료" : "편집")
                }
                .modifier(registButtonDesign(fillColor: CustomColor.editButton))
                

            }
            .frame(height: 40)
            
            NavigationStack {
                List(selection: $multiSelection) {
                    
                    Section {
                        ForEach( model.kind.dynamicGetArray(type: titleName), id: \.self ) { sub in
                            
                            Group {
                                if titleName == .color {
                                    HStack{
                                        Text( "\(sub.getNameColor[0])" )
                                        Spacer()
                                        Color.init(hex: sub.getNameColor[1])
                                            .frame(width: 100)
                                    }
                                } else {
                                    Text( "\(sub)" )
                                }
                            }
                            .font(.system(size: 16))
                            .padding(.vertical, 2)
                        }
                        .onDelete(perform: deleteData)
//                        .onMove { indexSet, num in
//
//                        }
                        
                    } header : {
                        Text("\(model.kind.dynamicGetArray(type: titleName).count)건")
                            .font(.callout)
                        
                    }
                    
                }
                .scrollContentBackground(.hidden)
                .background(CustomColor.listBackGround)
                .toastView(toast: $toast)
                .environment(\.editMode, .constant(isEditing ? .active : .inactive))

            }
            
        }
        .padding(8)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(CustomColor.frameColor)
        }
        .onAppear {
//            model.fetchData(whereData: [itemType.rawValue])
            model.fetchData(itemType: itemType)
            if titleName == .color {
                placeholoderName = "색상 선택 후 색상명을 입력바랍니다."
            }
            
        }
        .refreshable {
//            model.fetchData(whereData: [itemType.rawValue])
            model.fetchData(itemType: itemType)
            
        }
        
    }
    
    
    //MARK: - 등록, 수정, 삭제 관련 Methods
    private func registData() {
        var kind: Kind = .init(itemType: itemType.rawValue)
        
        if name != "" {
            if titleName == .color {
                if pickColor.isEmpty {
                    toast = Toast(style: .warning, message: "색상명을 입력해주세요.", width: 150)
                    return
                } else {
                    name = "\(name)/\(pickColor)"
                    pickColor = ""  //초기화
                }
            }
            
            kind.dynamicSetData(type: titleName, setData: name)
            //초기 데이터가 없으면 ADD, 그게 아니면 데이터확인후 Update or Add
            model.addUpData(data: kind, type: titleName)
            
            toast = Toast(style: .success, message: "등록되었습니다.", width: 150)

        } else {
            print("아무것도 입력되지 않았음.")
            toast = Toast(style: .error, message: "내용 입력 후 재시도바랍니다..", width: 230)
        }
        name = ""   //초기화 시키기
        
    }
    
    private func deleteData( removeData: IndexSet ) {
        model.removeData( itemType: itemType, type: titleName, indexSet: removeData)
        toast = Toast(style: .warning, message: "삭제되었습니다.",  width: 150)
        
    }
    
}

//MARK: - NameSpaces
extension CategorySubView {
    enum CustomColor {
        static let listBackGround: Color = Color(hex: "e6e6e6")
        static let frameColor: Color = Color(hex: "0F2C59")
        static let registButton: Color = Color(hex: "4F709C")
        static let editButton: Color = Color(hex: "4F709C")
    }
}

struct CategorySubView_Previews: PreviewProvider {
    static var previews: some View {
        CategorySubView(titleName: .color, itemType: .iphone, model: CategoryModel())
    }
}
