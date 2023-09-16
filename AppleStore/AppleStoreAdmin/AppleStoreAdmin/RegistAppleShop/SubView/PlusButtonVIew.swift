//
//  SwiftUIView.swift
//  AppleStoreAdmin
//
//  Created by 송성욱 on 2023/09/13.
//

import SwiftUI

struct PlusButtonVIew: View {
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .frame(width: 50)
                    .foregroundColor(Color.init(hex: "0F2C59"))
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
            }
            Text("Regist AppleStore")
                .fontWeight(.heavy)
                .fontDesign(.rounded)
                .font(.title2)
        }
      
        
    }
}

struct PlusButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlusButtonVIew()
    }
}
