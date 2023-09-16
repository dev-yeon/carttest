//
//  BestSearch.swift
//  AppSchoolStudy
//
//  Created by 박서연 on 2023/09/07.

import SwiftUI
import Kingfisher

struct BestSearch: View {

    @ObservedObject var selectedInfo: SelectedIphoneInfo
    @ObservedObject var selectedIpadInfo: SelectedIpadInfo
    @ObservedObject var viewModel: SearchViewModel

    @State var tempSeries = ""
    @State var selectedColors: [String] = []

    func filterColored(){

        // 시리즈로부터 색상 가져오기 위해서 시리즈값 받아오기
        guard let findColorFromSeries = viewModel.getFirstElement()?.seriesName else { return }

        for index in viewModel.productArray {
            if index.seriesName.contains(findColorFromSeries) {
                self.selectedColors.append(index.productColor)
            }
        }

    }

    func clearColor() {
        selectedColors.removeAll()
    }
    
    var body: some View {

        VStack(alignment: .leading) {
            Text("최우선 결과")
                .font(.system(size: 20, weight: .semibold))
            if !selectedInfo.resultSeriesButton.isEmpty {
                NavigationLink {
                    SearchResultTestView()
                } label: {
                    VStack(alignment: .leading)  {

                        KFImage(URL(string: selectedInfo.getBestElement()?.mainImageString ?? ""))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .frame(minHeight: 180)
                            .menuIndicator(.automatic)

                        VStack(alignment: .leading, spacing: 4){
                            if let bestData = selectedInfo.getBestElement() {

                                Text(bestData.productName)
                                    .font(.system(size: 15, weight: .semibold))
                                Text("₩\(bestData.price)부터")
                                    .font(.system(size: 15))
                                HStack(spacing: 4){
                                    ForEach(Array(selectedInfo.resultSeriesInfo), id: \.self) { colorString in
                                        Circle()
                                            .foregroundColor(Color(hex: colorString.productColor.getNameColor[1]))
                                            .frame(width: 13, height: 13)
                                    }
                                }
                            } else {
                                Text("일치하는 결과가 없습니다. 다시 검색해주세요.")
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .foregroundColor(.black)
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.white))
                    .shadow(color: Color(hex: "#dddddd"), radius: 3, x: 0, y: 5)
                )
            } else if !selectedIpadInfo.resultSeriesInfo.isEmpty {
                NavigationLink {
                    SearchResultTestView()
                } label: {
                    VStack(alignment: .leading)  {

                        KFImage(URL(string: selectedIpadInfo.getBestElement()?.mainImageString ?? ""))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .frame(minHeight: 180)
                            .menuIndicator(.automatic)
                            .padding(.bottom, 10)

                        VStack(alignment: .leading, spacing: 4){
                            if let bestData = selectedIpadInfo.getBestElement() {

                                Text(bestData.productName)
                                    .font(.system(size: 15, weight: .semibold))
                                Text("₩\(bestData.price)부터")
                                    .font(.system(size: 15))
                                HStack(spacing: 4){
                                    ForEach(Array(selectedIpadInfo.resultSeriesInfo), id: \.self) { colorString in
                                        Circle()
                                            .foregroundColor(Color(hex: colorString.productColor.getNameColor[1]))
                                            .frame(width: 13, height: 13)
                                    }
                                }
                            } else {
                                Text("일치하는 결과가 없습니다. 다시 검색해주세요.")
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .foregroundColor(.black)
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.white))
                    .shadow(color: Color(hex: "#dddddd"), radius: 3, x: 0, y: 5)
                )
            } else {
                NavigationLink {
                    SearchResultTestView()
                } label: {
                    VStack(alignment: .leading)  {
                        KFImage(URL(string: viewModel.getFirstElement()?.mainImageString ?? ""))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .frame(minHeight: 180)
                            .menuIndicator(.automatic)
                            .padding(.bottom, 10)


                        VStack(alignment: .leading, spacing: 4){
                            if let bestData = viewModel.getFirstElement() {

                                Text(bestData.productName)
                                    .font(.system(size: 15, weight: .semibold))
                                Text("₩\(bestData.price)부터")
                                    .font(.system(size: 15))
                                HStack(spacing: 4){
                                    ForEach(selectedColors, id: \.self) { colorString in
                                        Circle()
                                            .foregroundColor(Color(hex: colorString.getNameColor[1]))
                                            .frame(width: 13, height: 13)
                                    }
                                }
                            } else {
                                Text("일치하는 결과가 없습니다. 다시 검색해주세요.")
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .foregroundColor(.black)
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.white))
                    .shadow(color: Color(hex: "#dddddd"), radius: 3, x: 0, y: 5)
                )
                .onAppear() {
                    clearColor()
                    filterColored()
                }
            }
        }
    }
}
