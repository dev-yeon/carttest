//
//  ModelButtonView.swift
//  AppleStore
//
//  Created by SIKim on 2023/09/05.
//

import SwiftUI

struct ModelButtonView: View {
    @Binding var productName: String
    @Binding var price: Int
    @Binding var isCheckButton: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(productName)")
                    .foregroundColor(.black)
                    .padding(.bottom, 2)
                Text("(ex: 15.5cm 디스플레이¹)")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .padding(20.0)
            
            Spacer()
            
            Text("₩\(price)부터")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(
                    isCheckButton ? Color.blue : Color(.systemGray3),
                    lineWidth:
                        isCheckButton ? 3 : 1
                )
        )
        .padding(.horizontal)
        .disabled(isCheckButton)
    }
}

struct ModelButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ModelButtonView(productName: .constant("iPhone 14 Pro"), price: .constant(1250000), isCheckButton: .constant(true))
    }
}
