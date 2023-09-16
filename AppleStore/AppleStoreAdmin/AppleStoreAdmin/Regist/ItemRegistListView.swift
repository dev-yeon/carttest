//
//  ItemRegistListView.swift
//  AppleStoreAdmin
//
//  Created by woojin Shin on 2023/09/05.
//

import SwiftUI

//TODO: 아래 스크롤 감지해서 위로 바로 올라가는 버튼 만들어보기

///제품정보 리스트(현황)
struct ItemRegistListView: View {
    @ObservedObject var model: ItemViewModel
    @State private var selectID = ""
//    @State private var itemWhereData: String = "" //여러개 아님
//    @State private var dtlWhereDatas: [[String:String]] = .init()
    @Binding var itemWhereData: String
    @Binding var dtlWhereDatas: [[String:String]]

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            
            //MARK: 데이터 LIST
            List {
                Section {
                    ForEach(model.itemInfos){ item in
                        ItemListRowView(item: item, selectIndexID: $selectID)
                            .onTapGesture {
                                selectID = item.id
                                model.itemInfo = item
                                model.chgViewType = .add
                            }
                    }
                } header: {
                    Text("\(model.itemInfos.count)건")
                }
                
            }
            .scrollContentBackground(.hidden)
            .refreshable {
                fetchData()
            }
  
        }
        .onReceive(model.$chgViewType) { type in
            if type == .list {
                fetchData()
            }
        }

        
    }
    

    ///제품정보 불러오기
    func fetchData() {
        var whereFields = [String]() //조건명 필드
        var whereDatas = [String]()  //조건 데이터
        
        print("fetchData  \(itemWhereData), \(dtlWhereDatas)")
        
        print("fetchData  \(itemWhereData), \(dtlWhereDatas)")
        
        DispatchQueue.main.async {
            if !itemWhereData.isEmpty {
                whereFields.append("itemType")
                whereDatas.append(itemWhereData)
            }
            
            //상세분류가 선택이 되어있을경우
            if !dtlWhereDatas.isEmpty {

                for whereData in dtlWhereDatas {
                    whereFields.append(whereData.first!.key)
                    whereDatas.append(whereData.first!.value)
                    print("\(whereData.first!.value)")
                    
                }
            }

            model.fetchItemInfoArray(where: whereFields, whereData: whereDatas)
            
        }
    }
   
}




struct ItemRegistListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRegistEditView()
//        NavigationStack {
//            ItemRegistListView(model: ItemViewModel(), itemWhereData: .constant(""), dtlWhereDatas: .constant([[:]]))

//        }
    }
}
