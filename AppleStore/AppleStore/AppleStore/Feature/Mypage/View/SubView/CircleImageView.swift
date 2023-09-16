//
//  ProfileImageView.swift
//  AppleStore
//
//  Created by dayexx on 2023/09/05.
//

import SwiftUI
import Kingfisher

struct CircleImageView: View {
    var image : String
    var body: some View {
        KFImage(URL(string : image))
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .frame(width: 100, height: 100)
            .progressViewStyle(.automatic)
    }
}

struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageView(image: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-14-pro-model-unselect-gallery-1-202209?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1660753619946" )
    }
}
