//
//  SearchResultView.swift
//  AppSchoolStudy
//
//  Created by 박서연 on 2023/09/06.
//



import SwiftUI
import Kingfisher

struct SearchResultView: View {
    
    @ObservedObject var viewModel: SearchViewModel
    @ObservedObject var selectedInfo: SelectedIphoneInfo = SelectedIphoneInfo()
    @ObservedObject var selectedIpadInfo: SelectedIpadInfo = SelectedIpadInfo()
    
    @State var showFilter: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    FilterSearch(showFilter: $showFilter, viewModel: viewModel, selectedInfo: selectedInfo, selectedIpadInfo: selectedIpadInfo)
                    BestSearch(selectedInfo: selectedInfo, selectedIpadInfo: selectedIpadInfo, viewModel: viewModel)
                        .padding(.bottom, 20)
                    Text("추가 결과")
                        .font(.system(size: 20, weight: .semibold))
                    
                    if !selectedInfo.resultSeriesButton.isEmpty {
                        ForEach(Array(selectedInfo.resultSeriesInfo), id: \.self) { index in
                            NavigationLink {
                                SearchResultTestView()
                            } label: {
                                commonRow(index: index)
                            }
                        }
                    } else if !selectedIpadInfo.resultSeriesButton.isEmpty {
                        ForEach(Array(selectedIpadInfo.resultSeriesInfo), id: \.self) { index in
                            NavigationLink {
//                                PurchaseiPadView(seriesName: index.seriesName)
                            } label: {
                                commonRow(index: index)
                            }
                        }
                    } else {
                        ForEach(viewModel.searchResult, id: \.self) { index in
                            NavigationLink {
                                SearchResultTestView()
//                                PurchaseiPhoneView(seriesName: index.seriesName)
                            } label: {
                                commonRow(index: index)
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
    
    func commonRow(index: ItemInfo) -> some View {
        HStack {
            KFImage(URL(string: index.mainImageString))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .menuIndicator(.automatic)
            
            VStack(alignment: .leading) {
                Text("\(index.productName)")
                    .font(.system(size: 18, weight: .semibold))
                Text(index.price)
                    .font(.system(size: 13))
            }
            .foregroundColor(.black)
            
            Spacer()
            
            Text("〉")
                .font(.system(size: 30))
                .foregroundColor(.black)
        }
        .padding()
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(viewModel: SearchViewModel(), showFilter: false)
    }
}

//import SwiftUI
//import Kingfisher
//
//struct SearchResultView: View {
//
//    @ObservedObject var viewModel: SearchViewModel
//    @ObservedObject var selectedInfo: SelectedIphoneInfo = SelectedIphoneInfo()
//    @ObservedObject var selectedIpadInfo: SelectedIpadInfo = SelectedIpadInfo()
//
//    @State var showFilter: Bool = false
//
//    // Refactor the common view code into a separate function
//    @ViewBuilder
//    func commonView() -> some View {
//        VStack(alignment: .leading) {
//            FilterSearch(showFilter: $showFilter, viewModel: viewModel, selectedInfo: selectedInfo, selectedIpadInfo: selectedIpadInfo)
//
//            if !selectedInfo.resultSeriesButton.isEmpty {
//                VStack(alignment: .leading) {
//                    BestSearch(selectedInfo: selectedInfo, selectedIpadInfo: selectedIpadInfo, viewModel: viewModel)
//                        .padding(.bottom, 20)
//                    Text("추가 결과")
//                        .font(.system(size: 20, weight: .semibold))
//
//                    ForEach(Array(selectedInfo.resultSeriesInfo), id: \.self) { index in
//                        NavigationLink {
//                            SearchResultTestView()
//                        } label: {
//                            commonRow(index: index)
//                        }
//                    }
//                }
//            } else if !selectedIpadInfo.resultSeriesButton.isEmpty {
//                VStack(alignment: .leading) {
//                    BestSearch(selectedInfo: selectedInfo, selectedIpadInfo: selectedIpadInfo, viewModel: viewModel)
//                        .padding(.bottom, 20)
//                    Text("추가 결과")
//                        .font(.system(size: 20, weight: .semibold))
//
//                    ForEach(Array(selectedIpadInfo.resultSeriesInfo), id: \.self) { index in
//                        NavigationLink {
//                            SearchResultTestView()
//                        } label: {
//                            commonRow(index: index)
//                        }
//                    }
//                }
//            } else {
//                VStack(alignment: .leading) {
//                    BestSearch(selectedInfo: selectedInfo, selectedIpadInfo: selectedIpadInfo, viewModel: viewModel)
//                        .padding(.bottom, 20)
//                    Text("추가 결과")
//                        .font(.system(size: 20, weight: .semibold))
//
//                    ForEach(viewModel.searchResult, id: \.self) { index in
//                        NavigationLink {
//                            SearchResultTestView()
//                        } label: {
//                            commonRow(index: index)
//                        }
//                    }
//                }
//            }
//            Spacer()
//        }
//    }
//
//    // Refactor the common row code into a separate function
//    func commonRow(index: ItemInfo) -> some View {
//        HStack {
//            KFImage(URL(string: index.mainImageString))
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 30, height: 30)
//                .menuIndicator(.automatic)
////            AsyncImage(url: URL(string: index.mainImageString)) { image in
////                image
////                    .resizable()
////                    .aspectRatio(contentMode: .fit)
////                    .frame(width: 30, height: 30)
////            } placeholder: {
////                ProgressView()
////            }
//
//            VStack(alignment: .leading) {
//                Text("\(index.productName)")
//                    .font(.system(size: 18, weight: .semibold))
//                Text(index.price)
//                    .font(.system(size: 13))
//            }
//            .foregroundColor(.black)
//            Spacer()
//            Text("〉")
//                .font(.system(size: 30))
//                .foregroundColor(.black)
//        }
//        .padding()
//    }
//
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                commonView() // Use the commonView function
//            }
//        }
//    }
//}
//
//struct SearchResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchResultView(viewModel: SearchViewModel(), showFilter: false)
//    }
//}
