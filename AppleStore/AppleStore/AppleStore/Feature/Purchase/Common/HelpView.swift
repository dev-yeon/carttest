//
//  HelpView.swift
//  AppleStore
//
//  Created by SIKim on 2023/09/05.
//

import SwiftUI

struct HelpView: View {
    @State var isShowingTip: Bool = false
    @Binding var title: String
    @Binding var description: String
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.footnote)
                    .fontWeight(.semibold)
                Text(description)
                    .font(.footnote)
            }
            .padding()
            Spacer()
            Button {
                isShowingTip.toggle()
            } label: {
                Image(systemName: "info.circle")
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray5))
        .cornerRadius(5)
        .padding()
        .sheet(isPresented: $isShowingTip) {
            Text("준비중")
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HelpView(title: .constant("(ex: 모델 선택에 도움이 필요하신가요?)"), description: .constant("(ex: 화면 크기와 배터리 사용 시간 등 차이점을 비교해보세요.)"))
        }
    }
}
