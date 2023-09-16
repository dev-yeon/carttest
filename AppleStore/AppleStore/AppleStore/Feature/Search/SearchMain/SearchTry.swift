//
//  SearchTry.swift
//  AppSchoolStudy
//
//  Created by 박서연 on 2023/09/07.
//

import SwiftUI

struct SearchTry: View {
    
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("검색 시도")
                .font(.system(size: 20, weight: .semibold))
            List {
                ForEach(viewModel.productArray.prefix(5), id: \.self) { index in
                    NavigationLink {
                        SearchResultTestView()
                    } label: {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("\(index.productName)")
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

struct SearchTry_Previews: PreviewProvider {
    static var previews: some View {
        SearchTry(viewModel: SearchViewModel())
    }
}
