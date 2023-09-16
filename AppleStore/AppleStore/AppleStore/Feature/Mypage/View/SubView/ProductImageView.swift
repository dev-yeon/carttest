//
//  ProductImageView.swift
//  AppleStore
//
//  Created by dayexx on 2023/09/07.
//


import SwiftUI
import Kingfisher

struct ProductImageView: View {
    var image : String
    var body: some View {
        KFImage(URL(string : image))
            .resizable()
            .scaledToFit()
            .frame(width: 100,height: 100)
            .cornerRadius(8)
    }
}


struct ProductImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProductImageView(image: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-card-40-iphone14-202209?wid=680&hei=528&fmt=p-jpg&qlt=95&.v=1661958160674")
    }
}
