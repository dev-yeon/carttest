//
//  Enum+Extension.swift
//  AppleStore
//
//  Created by 박서연 on 2023/09/06.
//

import Foundation
import SwiftUI

/// hex 코드표를 사용하기 위한 Extenstion
extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        self.init(
            red: Double((rgb & 0xFF0000) >> 16) / 255.0,
            green: Double((rgb & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgb & 0x0000FF) / 255.0
        )
    }
}

/// 공통함수부분
/// 필터링을 위한 버튼 선택때 사용
class Utils {
    static func filterButton(selectedArray: inout [String], index: String) {
        if selectedArray.contains(index) {
            guard let temp = selectedArray.firstIndex(of: index) else { return }
            selectedArray.remove(at: temp)
        } else {
            selectedArray.append(index)
        }
    }
    
    

}

/// 모든 버튼의 공통 효과
struct ColorSelectionView: View {
    let color: String
    @Binding var selectedColorButton: [String]
    
    var body: some View {
        
        Button {
            Utils.filterButton(selectedArray: &selectedColorButton, index: color)
        } label: {
            VStack(spacing: 3) {
                Circle()
                    .shadow(color: .gray, radius: 0.5)
                    //Color(hex: "#c0c0c0")
                    .foregroundColor(Color(hex: color.getNameColor[1]))
                    .frame(width: 30, height: 30)
                    .padding(.all, 5)
                    .overlay(
                        Circle()
                            .stroke(selectedColorButton.contains(color) ? .blue : .clear)
                            .shadow(color: selectedColorButton.contains(color) ? .blue : .clear, radius: selectedColorButton.contains(color) ? 3 : 0)
                    )
            }
        }
    }
}

/// Button의 Modifier
struct SelectingButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12))
            .padding()
            .frame(maxWidth: .infinity)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray, lineWidth: 1))
            .cornerRadius(8)
    }
}

/// 색상값을 위한 String Extenstion - 우진님이 만들어줌 나중에 상인님이랑 겹치니까 이부분 확인 후 수정!!!
extension String {
    var getNameColor: [String] {
        let components = self.split(separator: "/").map { String($0) }
        
        var returnValue = components.isEmpty ? [""] : components
        
        //무조건 2개의 값을 만들어서 런타임에러 방지 ㅋㅎ
        for index in 0..<2 {
            //값이 있으면 패스 없으면 넣어준다.
            if !returnValue.indices.contains(index) {
                returnValue.insert("", at: index)
            }
        }
        
//        print("reee \(returnValue)")
        
        return returnValue
    }
    
}
