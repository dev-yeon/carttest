//
//  MainViewModel.swift
//  AppleStoreAdmin
//
//  Created by woojin Shin on 2023/09/05.
//

import SwiftUI


///NavigationSplitView 사이드바 대분류 컨텐츠
struct Category: Identifiable {
    let id = UUID().uuidString
    let title: String
    let contents: [DetailContent<AnyView>]
}


///NavigationSplitView Detail 컨텐츠
struct DetailContent<Content>: Identifiable where Content: View {
    let id = UUID().uuidString
    let title: String
    var type: MenuType = .write //디폴트 write
    let content: Content
    
    var sysImage: String {
        switch type {
        case .read:
            return "list.bullet.clipboard"
        case .write:
            return "square.and.pencil"
        }
    }
    
    enum MenuType {
        case read, write
        //read: 내역(현황), write: 입력
    }
}

//여기서 ViewModel을 생성하여 View에 주입시켜주기 때문에 MainActor를 넣어봄.ㅋ
@MainActor
final class MainViewModel {
   
    var categories = [Category]()
    static let shared: MainViewModel = .init()
    private let itemModel: ItemViewModel = .init()
//    private let appleShop: ShopModel = ShopModel.sampleData[0]


    init() {
        ///사이드바 카테고리
        categories = [
            //등록
            Category(title: "등록", contents: [
                //제품
                DetailContent(title: "제품 추가", content: ItemRegistAddView(model: ItemViewModel())
                    .convertAnyView()),
                DetailContent(title: "제품 현황", type: .read, content: ItemRegistEditView().convertAnyView()),
                
                //애플스토어
                DetailContent(title: "애플스토어 추가", content: ShopRegistListShop().convertAnyView())
            ]),
            
            //주문
            Category(title: "주문", contents: [
                DetailContent(title: "주문/배송 현황", type: .read, content: OrderMainView().convertAnyView()),
//                DetailContent(title: "취소/반품/교환", content: OrderMainView(viewMode: .request).convertAnyView()),
            ]),
            
            //회원관리
            Category(title: "회원관리", contents: [
                DetailContent(title: "회원정보", type: .read, content: UserInfoListView().convertAnyView()),
            ]),
            
            //카테고리
            Category(title: "카테고리", contents: [
                DetailContent(title: "아이폰", content: CategoryIphoneRegistView().convertAnyView()),
                DetailContent(title: "아이패드", content: CategoryIpadRegistView().convertAnyView())
            ])
        ]
    }
}


struct MainViewModel_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
