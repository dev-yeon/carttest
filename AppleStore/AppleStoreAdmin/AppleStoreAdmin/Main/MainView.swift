//
//  MainView.swift
//  AppleStoreAdmin
//
//  Created by woojin Shin on 2023/09/05.
//

import SwiftUI



//MARK: - 메인뷰
struct MainView: View {
    @State private var splitVisible: NavigationSplitViewVisibility = .all

    
    var body: some View {
        NavigationSplitView(columnVisibility: $splitVisible) {
            VStack(spacing: 20) {
                
                //TODO: - FireStore에서 값 받아와서 대체
                VStack(spacing: 30) {
                    Image(systemName: "applelogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 50)
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(Color.init(hex: HexColor.appleLogo))
                    
                    Text("admin@apple.com")
                        .tint(.black)
                    Spacer()
                }
                .padding(.bottom, 30)
                .frame(height: 100)
                
                
                Divider()
                
                
                List {
                    ForEach(MainViewModel.shared.categories) { category in
                        Section(header: Text(category.title).font(.title3).bold() ) {
                            ForEach(category.contents) { content in
                                NavigationLink {
                                    content.content
//                                        .environmentObject(itemModel)
                                    
                                } label: {
                                    Label("\(content.title)", systemImage: content.sysImage)
                                        .foregroundColor(.black)
                                        .padding(.leading)
                                }
                                
                            }
                            
                        }
                    }
                }
                .listStyle(.sidebar)    //디폴트
                .scrollContentBackground(.hidden)
                .accentColor(Color.gray) // Indicator 색상 변경
                
            }
            .navigationSplitViewColumnWidth(250)
            .background(Color.init(hex: HexColor.sideBar))
            
        }
    detail: {
        Text("Please choose a menu")
            .font(.title3)
            .foregroundColor(.gray)
            .navigationSplitViewColumnWidth(250)

    }
        
    }
}

 
//MARK: - NameSpace
enum HexColor {
    static let subCatogory = "CCD1E4"
    static let appleLogo = "344D67"
    static let sideBar = "CEE6F3"
    
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
