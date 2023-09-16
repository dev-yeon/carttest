//
//  ImageURLView.swift
//  AppleStoreAdmin
//
//  Created by woojin Shin on 2023/09/08.
//

import SwiftUI
import Kingfisher

struct ImageURLView: View {
    @Binding var imageURL: String
    
    var body: some View {
        VStack {
            KFImage(URL(string: imageURL))
                .placeholder({ _ in
                    Text("이미지 없음")
                        .foregroundColor(.gray)
                    
                }).retry(maxCount: 3, interval: .seconds(5))
                .cancelOnDisappear(true) //셀이 화면에서 안보일때는 로드하지 않음.
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.init(hex: "E4E4D0"), lineWidth: 2)
                .shadow(radius: 20)
        }
    }
}

struct ImageURLView_Previews: PreviewProvider {
    static var previews: some View {
        ImageURLView(imageURL: .constant("https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzA1MjlfMTMw%2FMDAxNjg1MzY4NjIzOTIy.Q6PL7C1wmLBfbsXjtuEQuMWSWH_EvduS96tpQ0G9ApIg.TFcpFe3eCnUq1hLWrdj3dsyunr8LMEDd94nq7yMyyN8g.JPEG.essue%2FKakaoTalk_20230529_223818705_02.jpg&type=ff332_332"))
            .frame(width: 300, height: 300)
    }
}
