//
//  ModelButtonView.swift
//  AppleStore
//
//  Created by SIKim on 2023/09/05.
//

import SwiftUI

struct ModelButtonView: View {
    let productName: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(productName)")
                    .foregroundColor(.black)
                    .padding(.bottom, 2)
                Text("(설명 ex: 15.4cm 디스플레이¹)")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .padding(20.0)
            
            Spacer()
            
            Text("(ex: ₩1,250,000부터)")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding()
        }
    }
}

struct ModelButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ModelButtonView(productName: "iPhone 14 Pro")
    }
}
