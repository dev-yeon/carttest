//
//  CellularButtonView.swift
//  Temp
//
//  Created by SIKim on 2023/09/13.
//

import SwiftUI

struct CellularButtonView: View {
    var embedCellular: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                ///wifi 모델
                Text("\(embedCellular)")
                ///cellular 모델
//                Text("Wi-Fi + Cellular")
                    .foregroundColor(.black)
                    .padding(.bottom, 2)
                ///wifi 모델
                Text("(설명 ex: 모든 iPad는 Wi-Fi 연결을 지원해 언제나 소통을 이어갈 수 있습니다.)")
                ///cellular 모델
//                Text("Wi-Fi + Cellular 모델은 Wi-Fi 연결이 불가능한 환경에서도 인터넷에 연결할 수 있죠.")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .padding(20.0)
            
            Spacer()
            
            Text("(ex: ₩1,250,000)")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding()
        }
    }
}

struct CellularButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CellularButtonView(embedCellular: "Wi-Fi")
    }
}
