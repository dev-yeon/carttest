//
//  HelpCellView.swift
//  AppleStore
//
//  Created by dayexx on 2023/09/05.
//

import SwiftUI

struct SupportCellView: View {
    var titleText: String
    var image: String
    var subTitle: String
    var explain: String
    var frameHeight: Int
    var body: some View {
        VStack{
            Text(titleText).bold().frame(width:350, alignment:.leading)
            Divider()
            HStack{
                Image(systemName: image).font(.largeTitle).padding()
                Spacer()
                VStack(alignment: .leading){
                    Text(subTitle).bold()
                    Spacer()
                    Text(explain).font(.footnote).foregroundColor(.gray)
                }
                Spacer(minLength: 60)
                
            }.frame(maxHeight:CGFloat(frameHeight)).padding()
            Divider()
        }.foregroundColor(.black)
    }
}

/*
struct HelpCellView_Previews: PreviewProvider {
    static var previews: some View {
        HelpCellView()
    }
}
*/
