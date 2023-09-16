//
//  StorageButtonView.swift
//  AppleStore
//
//  Created by SIKim on 2023/09/06.
//

import SwiftUI

struct StorageButtonView: View {
    var storage: String
    var body: some View {
        VStack {
            Group {
                Text("\(storage)")
                    .foregroundColor(.black)
                    .padding([.top], 25.0)
                Text("기격(₩1,250,000)")
                    .foregroundColor(.gray)
                    .padding([.bottom], 25.0)
            }
            .font(.footnote)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct StorageButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StorageButtonView(storage: "128GB")
    }
}
