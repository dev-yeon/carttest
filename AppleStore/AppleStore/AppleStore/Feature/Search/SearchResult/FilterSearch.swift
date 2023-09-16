//
//  FilterSearch.swift
//  AppSchoolStudy
//
//  Created by 박서연 on 2023/09/07.
//

import SwiftUI

struct FilterSearch: View {
    
    @Binding var showFilter: Bool
    @ObservedObject var viewModel: SearchViewModel
    @ObservedObject var selectedInfo: SelectedIphoneInfo
    @ObservedObject var selectedIpadInfo: SelectedIpadInfo
    
    var body: some View {
        VStack {
            HStack {
                Text("필터: ")
                    .bold()
                Button {
                    showFilter.toggle()
                } label: {
                    Text("기타")
                        .font(.system(size: 17))
                        .frame(width: 80, height: 40)
                        .foregroundColor(.black)
                        .overlay (RoundedRectangle(cornerRadius: 4).strokeBorder(Color(UIColor.systemGray3), lineWidth: 1.5))
                }
                .background(.white)
                .cornerRadius(4)
                .sheet(isPresented: $showFilter) {
                    FilterView(viewModel: viewModel, selectedIphoneInfo: selectedInfo, selectedIpadInfo: selectedIpadInfo)
                }
                Spacer()
            }
            Divider()
        }
        .background(.clear)        
    }
}

struct FilterSearch_Previews: PreviewProvider {
    static var previews: some View {
        FilterSearch(showFilter: .constant(false), viewModel: SearchViewModel(), selectedInfo: SelectedIphoneInfo(), selectedIpadInfo: SelectedIpadInfo())
    }
}
