//
//  CellularPickView.swift
//  Temp
//
//  Created by SIKim on 2023/09/13.
//

import SwiftUI

struct CellularPickView: View {
    @ObservedObject var itemStore: ItemStore
    @State private var selectedTabIndex: [String: Bool] = [:]
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("연결성.")
                    .fontWeight(.bold)
                
                Text("인터넷 연결 방식을 선택하세요.")
                
                Spacer()
            }
            .padding()
            .font(.title2)
            
            ForEach(Array(itemStore.embedCellularSet).sorted(), id: \.self) { embedCellular in
                CellularButtonView(embedCellular: embedCellular)
                    .onTapGesture {
                        for cellular in itemStore.embedCellularSet {
                            selectedTabIndex[cellular] = (cellular == embedCellular)
                        }
                        itemStore.embedCellular = embedCellular
                        print("\(itemStore.embedCellular)")
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(selectedTabIndex[embedCellular] ?? false ? Color.blue : Color(.systemGray3), lineWidth: selectedTabIndex[embedCellular] ?? false ? 3 : 1)
                    )
                    .padding(.horizontal)
            }
        }
    }
}

struct CellularPickView_Previews: PreviewProvider {
    static var previews: some View {
        CellularPickView(itemStore: ItemStore())
    }
}
