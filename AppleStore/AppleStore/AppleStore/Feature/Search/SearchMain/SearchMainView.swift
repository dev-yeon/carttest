//
//  SearchMainView.swift
//  AppleStore
//
//  Created by 박서연 on 2023/09/06.
//

import SwiftUI

enum SearchingState {
    case none, searching, finished
}

struct SearchMainView: View {
    @State private var showFilter: Bool = false
    @ObservedObject var viewModel: SearchViewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
                VStack {
                    switch viewModel.searchingState {
                    case .none:
                        SearchTry(viewModel: viewModel)

                    case .searching:
                        if viewModel.searchWord.count > 2 {
                            List {
                                ForEach(viewModel.searchResult, id: \.self) { index in
                                    NavigationLink {
                                        SearchResultTestView()
                                    } label: {
                                        HStack {
                                            Image(systemName: "magnifyingglass")
                                            Text(index.productName)
                                        }
                                    }
                                }
                            }.listStyle(.plain)
                        } else {
                            NavigationLink {
                                // MARK: - 여기 맵뷰 시작
                                MapView()
                            } label: {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: "magnifyingglass")
                                        Text("지도 및 매장 검색")
                                    }
                                    Divider()
                                }
                            }
                            .foregroundColor(.gray)
                            Spacer()
                        }
                        
                    case .finished:
                        SearchResultView(viewModel: viewModel)
                    }
                }
                .padding()
                
                .navigationTitle("검색")
                
        }
        .searchable(text: $viewModel.searchText, prompt: "검색어를 입력해주세요")
        .onAppear() {
            viewModel.fetchProduct()
        }
        .onSubmit(of: .search) { // 검색 완료
            print("검색완료")
            viewModel.updateResults()
            viewModel.searchingState = .finished
        }
        .onChange(of: viewModel.searchText) { newValue in
            print("newValue : \(newValue)")
            viewModel.searchingState = .searching

            viewModel.searchResult = viewModel.productArray.filter({ itemInfo in
                return itemInfo.productName.localizedStandardContains(viewModel.searchText)
            })
            
            // 테스트용
            print("viewModel.searchWord : \(viewModel.searchWord)") // 한글자씩 단어
            print("viewModel.searchResult : \(viewModel.searchResult)") // 구조체 자체 결과
            
            // 결과 확인
            viewModel.updateResults()
            viewModel.filterTest()
            
            
            // 취소 버튼 누를때 메인화면으로 ..
            if newValue.isEmpty {
                viewModel.searchingState = .none
            }
        }
        .onChange(of: viewModel.searchingState ){ state in
            if state == .none {
                viewModel.clearResults()
                print("state : \(state)")
            } else if state == .searching {
                viewModel.clearResults()
            } else {
                print("searchingState state 타는중 : \(viewModel.searchResult)")
            }
        }

    }
}

struct SearchMainView_Previews: PreviewProvider {
    static var previews: some View {
        SearchMainView()
    }
}
