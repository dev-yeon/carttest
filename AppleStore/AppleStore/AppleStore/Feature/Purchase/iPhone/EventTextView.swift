//
//  EventTextView.swift
//  AppleStore
//
//  Created by SIKim on 2023/09/07.
//

import SwiftUI

struct EventTextView: View {
    var body: some View {
        Text("iPhone과 함께 누리는 Apple Music 6개월 무료 혜택.◊◊")
            .padding()
            .font(.caption2)
        Divider()
    }
}

struct EventTextView_Previews: PreviewProvider {
    static var previews: some View {
        EventTextView()
    }
}
