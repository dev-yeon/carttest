//
//  StoragePickView.swift
//  AppleStore
//
//  Created by SIKim on 2023/09/06.
//

import SwiftUI

struct StoragePickView: View {
    @ObservedObject var itemStore: ItemStore
    @State private var selectedTabIndex: [String: Bool] = [:]

    var body: some View {
        VStack {
            HStack {
                ///아이폰일 경우
                Text("저장 용량.")
                ///아이패드일 경우
                
                    .fontWeight(.bold)
                ///아이폰일 경우
                Text("당신에게 알맞은 저장 용량은?")
                ///아이패드일 경우
                ///
                Spacer()
            }
            .padding()
            .font(.title2)
            
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 15), GridItem(.flexible(), spacing: 15)]) {
                ForEach(sortStorage(storages: Array(itemStore.storageSet)), id: \.self) { storage in
                    StorageButtonView(storage: storage)
                        .onTapGesture {
                            for tempStorage in itemStore.storageSet {
                                selectedTabIndex[tempStorage] = (tempStorage == storage)
                            }
                            itemStore.storage = storage
                            print("\(itemStore.selectedItems)")
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(selectedTabIndex[storage] ?? false ? Color.blue : Color(.systemGray3), lineWidth: selectedTabIndex[storage] ?? false ? 3 : 1)
                        )
                }
            }
            .padding(.horizontal)
            
            ///그냥 글만 대부분 적혀있어서 뷰를 그릴 수 있을 것 같은데 확인 필요
        }
    }
    
    func sortStorage(storages: [String]) -> [String] {
        let sortedStorages = storages.sorted { (storage1, storage2) -> Bool in
            let (number1, unit1) = divideStorageString(storageString: storage1)
            let (number2, unit2) = divideStorageString(storageString: storage2)
            let unitOrder: [String : Int] = [ "GB" : 0, "TB" : 1]
            if let intNumber1 = Int(number1), let intNumber2 = Int(number2) {
                if intNumber1 != intNumber2 {
                    if unit1 == unit2 {
                        return intNumber1 < intNumber2
                    }
                }
                return unitOrder[unit1] ?? 0 < unitOrder[unit2] ?? 0
            }
            return storage1 < storage2
        }
        return sortedStorages
    }
    
    func divideStorageString(storageString: String) -> (String , String) {
        let number = storageString.filter { "0123456789".contains($0) }
        let unit = storageString.filter { !"0123456789".contains($0) }
        return (number, unit)
    }
}

struct StoragePickView_Previews: PreviewProvider {
    static var previews: some View {
        StoragePickView(itemStore: ItemStore())
    }
}
