//
//  ColorButtonView.swift
//  AppleStore
//
//  Created by SIKim on 2023/09/06.
//

import SwiftUI

struct ColorButtonView: View {
    @Binding var colorName: String
    @Binding var isCheckButton: Bool
    
    private var colorView: Color {
        switch (colorName) {
        case "딥 퍼플", "퍼플":
            return Color.purple
        case "골드", "옐로":
            return Color.yellow
        case "실버", "화이트":
            return Color(.systemGray6)
        case "스페이스 블랙", "스페이스 그레이":
            return Color.gray
        case "블루":
            return Color.blue
        case "미드나이트":
            return Color.primary
        case "스타라이트":
            return Color(.systemGray5)
        case "(PRODUCT)RED":
            return Color.red
        case "핑크":
            return Color.pink
        case "그린":
            return Color.green
        default:
            break
        }
        return .clear
    }
    var body: some View {
        VStack {
            Group {
                Circle()
                    .fill(colorView)
                    .frame(width: 20, height: 20)
                    .overlay(Circle().stroke(Color.gray, lineWidth: 0.1))
                    .padding([.top], 25.0)
                Text("\(colorName)")
                    .font(.footnote)
                    .foregroundColor(.black)
                    .padding([.bottom], 25.0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(
                    isCheckButton ? Color.blue : Color(.systemGray3),
                    lineWidth: isCheckButton ? 3 : 1
                )
        )
    }
}

struct ColorButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ColorButtonView(colorName: .constant("스페이스 블랙"), isCheckButton: .constant(true))
    }
}
