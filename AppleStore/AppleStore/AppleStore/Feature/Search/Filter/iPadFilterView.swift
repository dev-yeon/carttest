//
//  iPadFilterView.swift
//  AppleStore
//
//  Created by 박서연 on 2023/09/06.
//


import SwiftUI

class SelectedIpadInfo: ObservableObject {
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
    
    @Published var bestIpadColors: [String] = []
    
}

struct iPadFilterView: View {
    
    @ObservedObject var viewModel: SearchViewModel
    @ObservedObject var selectedIpadInfo: SelectedIpadInfo
    
    @State private var selectedStorageButton: [String] = [] // 용량
    @State private var selectedSeriesButton: [String] = [] // 시리즈
    @State private var selectedColorButton: [String] = [] // 색상 테스트

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                Text("iPad")
                    .font(.system(.largeTitle))
                
                // MARK: - 종류
                VStack(alignment: .leading)  {
                    Text("시리즈")
                        .font(.headline)
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 5), GridItem(.flexible())], spacing: 5) {
                        if let seriesData = viewModel.ipadData?.series {
                            ForEach(seriesData, id: \.self) { kind in
                                Button {
                                    Utils.filterButton(selectedArray: &selectedIpadInfo.selectedSeriesButtonTest, index: kind)
                                    print("selectedIpadInfo.selectedSeriesButtonTest \(selectedIpadInfo.selectedSeriesButtonTest)")
                                } label: {
                                    Text("\(kind)")
                                        .modifier(SelectingButtonModifier())
                                        .foregroundColor(selectedIpadInfo.selectedSeriesButtonTest.contains(kind) ? .blue : .black)
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
                            ForEach(viewModel.ipadData?.colors ?? ["#FFFFFF"], id: \.self) { color in
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
                
                // MARK: - 유형
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



struct iPadFilterView_Previews: PreviewProvider {
    static var previews: some View {
        iPadFilterView(viewModel: SearchViewModel(), selectedIpadInfo: SelectedIpadInfo())
    }
}
