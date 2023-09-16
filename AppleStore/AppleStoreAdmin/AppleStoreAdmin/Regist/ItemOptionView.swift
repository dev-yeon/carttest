//
//  ItemListOptionView.swift
//  AppleStoreAdmin
//
//  Created by woojin Shin on 2023/09/11.
//

import SwiftUI

struct ItemOptionView: View {
    @ObservedObject var itemModel: ItemViewModel
    
    @State private var istotalCaseClicked  = true
    @State private var istotalCase2Clicked = true
    
    @Binding var itemWhereData: String  //여러개 아님
    @Binding var dtlWhereDatas: [[String:String]]
    
    @State private var buttonIndex: Int = 0
    @State private var button2Index: Int = 0
    @State private var selectKeyIndex: Int = 0
    @State private var isDetailed = false
    
    let fetchData: () -> Void
    

    var selectOptions: some View {
        HStack {
            ForEach(dtlWhereDatas, id: \.self) { dictionary in
                
                ForEach(dictionary.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                    Text("\(key.convertColName): \(value.getNameColor[0]) / ")
                }
                .font(.caption)
                .foregroundColor(.gray)
                
            }
        }
    }
    
    var body: some View {
        VStack(alignment:.leading, spacing: 8) {
            //MARK: 대분류 필터
            Text("제품분류")
                .font(.caption)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    Button {
                        istotalCaseClicked = true
                        itemWhereData = ""
                        fetchData()
                        
                    } label: {
                        Text("전체")
                            .font(.subheadline)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(istotalCaseClicked ? ButtonColor.clickColor : ButtonColor.mainColor, lineWidth: 1.5)

                    }
                    .foregroundColor(istotalCaseClicked ? ButtonColor.clickTextColor : ButtonColor.mainTextColor)
                    
                    
                    ForEach(Array(ItemType.allCases.enumerated()), id: \.element.id) { index, item in
                        Button {
                            istotalCaseClicked = false
                            buttonIndex = index
                            
                            itemWhereData = item.rawValue
                            
                            fetchData()
                            
                        } label: {
                            Text(item.rawValue)
                                .font(.subheadline)
                        }
//                        .padding()
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(istotalCaseClicked ? ButtonColor.mainColor : buttonIndex == index ? ButtonColor.clickColor : ButtonColor.mainColor, lineWidth: 1.5)
                            
                        }
                        .foregroundColor(istotalCaseClicked ? ButtonColor.mainTextColor : buttonIndex == index ? ButtonColor.clickTextColor : ButtonColor.mainTextColor)
                    }
                }
//                .frame(height: 30)
                
            }
            
            
            //MARK: 세부정보 필터
            Button {
                isDetailed.toggle()
            } label: {
                HStack {
                    Text("상세분류")
                        .font(.caption)
                        .foregroundColor(.blue)
                    
                    selectOptions
                    
                }
            }
            .sheet(isPresented: $isDetailed, onDismiss: {
                fetchData()
            }) {
                VStack(alignment: .leading, spacing: 10) {
                    selectOptions
                        .padding(.leading, 3)
                    
                    
                    Button {
                        istotalCase2Clicked = true
                        dtlWhereDatas.removeAll()
//                        fetchData()
                    } label: {
                        Text("전체")
                            .font(.subheadline)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(istotalCase2Clicked ? ButtonColor.click2Color : ButtonColor.main2Color, lineWidth: 1.5)
                        
                    }
                    .foregroundColor(istotalCase2Clicked ? ButtonColor.click2TextColor : ButtonColor.main2TextColor)
                    
                    
                    ForEach(itemModel.categorys.keys.sorted(), id: \.self) { key in
                        Text(key.convertColName)
                            .font(.title3)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                
                                ForEach(itemModel.categorys[key]!.indices, id: \.self){ index in
                                    let value = itemModel.categorys[key]![index]
                                    
                                    Button {
                                        istotalCase2Clicked = false
                                        selectKeyIndex = itemModel.categorys.keys.sorted().firstIndex(of: key)!
//                                        print("selectKeyIndex \(selectKeyIndex)")
                                        button2Index = index
//                                        dtlWhereDatas.removeAll()
                                        
                                        if dtlWhereDatas.contains([key : value]) {
                                            if let index = dtlWhereDatas.firstIndex(where: { $0[key] == value }) {
                                                dtlWhereDatas.remove(at: index)
                                            }
                                        } else {
                                            dtlWhereDatas.append([key : value])
                                        }
                                        
                                        dicSort()   //key순서로 정렬
                                        
//                                        fetchData()
                                  
                                    } label: {
                                        VStack {                                          if !value.getNameColor[1].isEmpty {
                                            Circle()
                                                .fill(Color(hex: value.getNameColor[1]))
                                                .frame(width: 15)
                                        }
                                            
                                            Text(value.getNameColor[0])
                                                .font(.subheadline)
                                        }
                                    }
                                    .padding(.horizontal)
                                    .padding(.vertical, 10)
                                    .background {
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(istotalCase2Clicked ? ButtonColor.main2Color :
                                                        dtlWhereDatas.contains([key:value]) ? ButtonColor.click2Color : ButtonColor.main2Color , lineWidth: 1.5
                                                    
                                                   
                                            )
                                        
                                    }
                                    .foregroundColor(istotalCase2Clicked ? ButtonColor.main2TextColor :
                                                        dtlWhereDatas.contains([key:value]) ? ButtonColor.click2TextColor : ButtonColor.main2TextColor)
                                    
                                }
                                
                            }
//                            .frame(height: 30)
                        }
                    }
                    Spacer()
                }
                .padding()
                
            }
            
        }
        .onAppear {
            itemModel.makeCategoryArray()
            itemModel.fetchItemInfoArray()
        }
        
    }
    
    ///key 기준으로 sort
    func dicSort() {
        dtlWhereDatas.sort { dic1, dic2 in
            let keys1 = dic1.keys.sorted()
            let keys2 = dic2.keys.sorted()
            
            return keys1.lexicographicallyPrecedes(keys2)
        }
    }
    
}


extension ItemOptionView {
    enum ButtonColor {
        static let mainColor = Color(hex: "B9B4C7")
        static let clickColor = Color(hex: "352F44")
        static let main2Color = Color(hex: "B9B4C7")
        static let click2Color = Color(hex: "352F44")
        static let mainTextColor = Color(hex: "B9B4C7")
        static let clickTextColor = Color(hex: "213555")
        static let main2TextColor = Color(hex: "B9B4C7")
        static let click2TextColor = Color(hex: "213555")
    }
}

struct ItemListOptionView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRegistEditView()
//        ItemRegistListView(model: ItemViewModel())
//        ItemOptionView(itemModel: ItemViewModel())
    }
}
