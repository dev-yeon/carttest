//
//  iPhoneFilterView.swift
//  AppleStore
//
//  Created by 박서연 on 2023/09/06.
//

/// 색상 별로 해당 색상이 있는 제품 시리즈를 보여주기
/// 시리즈 선택 시 시리즈만 걸러서 보여주기 iphon12 선택시 13,14는 결과값에 포함되지 않도록
/// 용량은.. ??

import SwiftUI

class SelectedIphoneInfo: ObservableObject {
    @Published var selectedSeriesButtonTest: [String] = []
    @Published var selectedStorageButtonTest: [String] = []
    @Published var selectedColorButtonTest: [String] = []
    
    @Published var resultSeriesButton: [String] = []
    @Published var resultSeriesInfo: Set<ItemInfo> = []// [ItemInfo] = []
    
    /// 검색 결과값의 첫번째를 가져오는 함수
    func getBestElement() -> ItemInfo? {
        if resultSeriesInfo.isEmpty {
            return nil
        }
        return self.resultSeriesInfo.first
    }
    
    /// 첫번째 결과값으로부터 색상값을 빼오는 함수
    func getBestColors() -> [String] {
        
        
        
        return [""]
    }
    /*
     for test in viewModel.productArray {
         for series in selectedIphoneInfo.resultSeriesButton {
             if test.seriesName.contains(series) {
                 selectedIphoneInfo.resultSeriesInfo.insert(test)
             }
         }
     }
     */
}

struct iPhoneFilterView: View {
    
    @ObservedObject var viewModel: SearchViewModel
    @ObservedObject var selectedInfo: SelectedIphoneInfo
    
    @State var selectedSeriesButton: [String] = [] // 시리즈
    @State var selectedStorageButton: [String] = [] // 용량
    @State var selectedColorButton: [String] = [] // 색상 테스트

    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                Text("iPhone")
                    .font(.system(.largeTitle))
                
                // MARK: - iPhone 종류
                VStack(alignment: .leading) {
                    Text("시리즈")
                        .font(.headline)
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 5), GridItem(.flexible())], spacing: 5) {
                        
                        if let seriesData = viewModel.iphoneData?.series {
                            ForEach(seriesData, id: \.self) { kind in
                                Button {
                                    Utils.filterButton(selectedArray: &selectedInfo.selectedSeriesButtonTest, index: kind)
                                    print("\(selectedInfo.selectedSeriesButtonTest)")
                                } label: {
                                    Text("\(kind)")
                                        .modifier(SelectingButtonModifier())
                                        .foregroundColor(selectedInfo.selectedSeriesButtonTest.contains(kind) ? .blue : .black)
                                }
                            }
                        } else {
                            Text("ERROR! Not Find Series Data")
                        }
                    }
                }
                
                // MARK: - 색상
                VStack(alignment: .leading) {
                    Text("색상")
                        .font(.headline)
                    ScrollView(.horizontal, showsIndicators: true) {
                        LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                            ForEach(viewModel.iphoneData?.colors ?? ["#FFFFFF"], id: \.self) { color in
                                VStack {
                                    ColorSelectionView(color: color, selectedColorButton: $selectedColorButton)
                                    Text(color.getNameColor[0])
                                        .font(.system(size: 10, weight: .light))
                                }
                            }
                        }
                        .padding(.vertical, 10)
                    }
                }
                
                // MARK: - 용량
                VStack(alignment: .leading) {
                    Text("용량")
                        .font(.headline)
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 5), GridItem(.flexible())], spacing: 5) {
                        if let storages = viewModel.ipadData?.storages {
                            ForEach(storages, id: \.self) { storage in
                                Button {
                                    Utils.filterButton(selectedArray: &selectedStorageButton, index: storage)
                                    print(selectedStorageButton)
                                } label: {
                                    Text("\(storage)")
                                        .modifier(SelectingButtonModifier())
                                        .foregroundColor(selectedStorageButton.contains(storage) ? .blue : .black)
                                }
                            }
                        } else {
                            Text("ERROR! Not Find Storage Data")
                        }
                    }
                }
            }
        }
        
    }
}


struct iPhoneFilterView_Previews: PreviewProvider {
    static var previews: some View {
        iPhoneFilterView(viewModel: SearchViewModel(), selectedInfo: SelectedIphoneInfo())
    }
}
