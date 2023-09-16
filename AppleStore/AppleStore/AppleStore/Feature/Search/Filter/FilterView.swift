//
//  FilterView.swift
//  AppleStore
//
//  Created by 박서연 on 2023/09/06.
//

import SwiftUI

enum SelectedButton {
    case button1, button2
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .padding()
            .background(.clear)
            .foregroundColor(.black)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray, lineWidth: 0.4))
            .opacity(configuration.isPressed ? 0.7 : 1)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}


struct FilterView: View {
    
    @State private var selectedButton: SelectedButton?
    @ObservedObject var viewModel: SearchViewModel
    @ObservedObject var selectedIphoneInfo: SelectedIphoneInfo
    @ObservedObject var selectedIpadInfo: SelectedIpadInfo
    
    @Environment(\.dismiss) private var dismiss
    
    
    // MARK: - test
    // filter 구현 - 시리즈
    func filterSeries() {
        
        // 전체 상품에서 filterview에서 선택한 값들을 가진 시리즈 필터링
        for test in viewModel.productArray {
            for series in selectedIphoneInfo.selectedSeriesButtonTest {
                if test.seriesName.contains(series) {
                    selectedIphoneInfo.resultSeriesButton.append(test.seriesName)
                }
            }
        }

        for test in viewModel.productArray {
            for series in selectedIphoneInfo.resultSeriesButton {
                if test.seriesName.contains(series) {
                    selectedIphoneInfo.resultSeriesInfo.insert(test)
                }
            }
        }
    }

    func filteriPadSeries() {
        
        // 전체 상품에서 filterview에서 선택한 값들을 가진 시리즈 필터링
        for test in viewModel.productArray {
            for series in selectedIpadInfo.selectedSeriesButtonTest {
                if test.seriesName.contains(series) {
                    selectedIpadInfo.resultSeriesButton.append(test.seriesName)
                }
            }
        }

        for test in viewModel.productArray {
            for series in selectedIpadInfo.resultSeriesButton {
                if test.seriesName.contains(series) {
                    selectedIpadInfo.resultSeriesInfo.insert(test)
                }
            }
        }
        
        /*
         guard let findColorFromSeries = viewModel.getFirstElement()?.seriesName else { return }
         
         for index in viewModel.productArray {
             if index.seriesName.contains(findColorFromSeries) {
                 self.selectedColors.append(index.productColor)
             }
         }
         */
        
    }

    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Button {
                            selectedButton = .button1
                        } label: {
                            Text("iPhone")
                        }
                        
                        Button {
                            selectedButton = .button2
                        } label: {
                            Text("iPad")
                        }
                    }
                    .font(.system(size: 14))
                    .foregroundColor(Color.black)
                    .buttonStyle(CustomButtonStyle())
                    .padding(.all, 5)
                }
    
                
                switch selectedButton {
                case .button1:
                    iPhoneFilterView(viewModel: viewModel, selectedInfo: selectedIphoneInfo)
                case .button2:
                    iPadFilterView(viewModel: viewModel, selectedIpadInfo: selectedIpadInfo)
                case .none:
                    EmptyView()
                }
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("완료 버튼 tapped")
                        filteriPadSeries()
                        filterSeries()
                        filteriPadSeries()
                        dump("selectedInfo.resultSeriesInfo : \(selectedIphoneInfo.resultSeriesInfo)")
                        dump("selectedIpadInfo.resultSeriesInfo : \(selectedIpadInfo.resultSeriesInfo)")
                        dismiss()
                    } label: {
                        Text("완료")
                    }
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("재설정 버튼 tapped")
                        selectedButton = .none
                    } label: {
                        Text("재설정")
                    }
                    
                }
            }
            .navigationTitle("기타")
            .onAppear() {
                // ipad 데이터 패치해오기
                viewModel.ipadFetch()
                viewModel.iphoneFetch()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(viewModel: SearchViewModel(), selectedIphoneInfo: SelectedIphoneInfo(), selectedIpadInfo: SelectedIpadInfo())
    }
}
