//
//  ToastView.swift
//  AppleStoreAdmin
//
//  Created by woojin Shin on 2023/09/07.
//

import SwiftUI

struct ToastView: View {
    
    var style: ToastStyle
    var message: String
    var width = CGFloat.infinity
    
    var body: some View {
        ZStack {
            HStack(alignment: .center, spacing: 12) {
                Image(systemName: style.iconStyle)
                    .foregroundColor(style.themeColor)
                Text(message)
                    .font(Font.caption)
                    .foregroundColor(Color.black)
                    .lineLimit(2)
                
            }
            .background(Color.white)
            .tint(Color.white)
            .foregroundColor(.white)
            .padding()
            .frame(minWidth: 0, maxWidth: width)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .opacity(0.1)
                
            )
            .padding(.horizontal, 16)
        }
    }
}


struct ToastView_Preview: PreviewProvider {
    static var previews: some View {
        ToastView(style: .success, message: "성공", width: .infinity)
    }
}
