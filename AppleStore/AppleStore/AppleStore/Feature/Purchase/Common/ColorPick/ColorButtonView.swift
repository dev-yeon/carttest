//
//  ColorButtonView.swift
//  AppleStore
//
//  Created by SIKim on 2023/09/06.
//

import SwiftUI

struct ColorButtonView: View {
    var colorName: String
    var colorArray: [String] {
        colorName.getNameColor
    }
    var body: some View {
        VStack {
            Group {
                Circle()
                    .fill(Color(hex: colorArray[1]))
                    .frame(width: 20, height: 20)
                    .padding([.top], 25.0)
                Text("\(colorArray[0])")
                    .font(.footnote)
                    .foregroundColor(.black)
                    .padding([.bottom], 25.0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct ColorButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ColorButtonView(colorName: "블루")
    }
}
