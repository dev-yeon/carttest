//
//  ProductViewModel.swift
//  AppleStore
//
//  Created by KangHo Kim on 2023/09/12.
//

import Foundation

///
final class ProductViewModel: ObservableObject {
    @Published var productCategories: [ProductsCategory] = []
    @Published var allProducts: [Product] = []
    
    init() {
        let iPhone = ProductsCategory(
            name: "iPhone",
            imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-pro-deeppurple-witb-202209?wid=346&hei=784&fmt=jpeg&qlt=90&.v=1660789320288",
            products: [
                Product(name: "iPhone 14 Pro", description: "항공우주 등급 티타늄 디자인을 갖춘 최초의 iPhone. 게임의 판도를 바꾸는 A17 Pro 칩. 맞춤형 ‘동작’ 버튼. iPhone 사상 가장 강력한 카메라 시스템. 여기에 초고속 전송 속도를 자랑하는 USB 3 규격 USB-C까지.*", price: 1550000, imageURLString: "https://www.apple.com/kr/iphone-15-pro/a/images/overview/closer-look/all_colors__eppfcocn9mky_small_2x.jpg", detailWebURLString: "https://www.apple.com/kr/iphone-15-pro/"),
                Product(name: "iPhone 14", description: "iPhone 15 Pro보다는 떨어지지만 그에 못지 않는 성능. Dynamic 어쩌구. 초고해상도 사진 어쩌구. 컬러 인퓨즈 글래스, 알루미늄 디자인.", price: 1250000, imageURLString: "https://www.apple.com/v/iphone-15/a/images/overview/contrast/iphone_15__dozjxuchowcy_small_2x.jpg", detailWebURLString: "https://www.apple.com/kr/iphone-15/"),
                Product(name: "iPhone 13", description: "이거 그린이 예쁜. 설명할 때 ~입니다로 안 끝나고 ~한, ~은으로 끝나는건 어디서 배워먹은?", price: 950000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-mini-green-witb-202203?wid=328&hei=784&fmt=jpeg&qlt=90&.v=1644964732550", detailWebURLString: "https://www.apple.com/kr/shop/buy-iphone/iphone-13"),
                Product(name: "iPhone SE", description: "놀라운 성능. 합리적인 선택. 이 모든 것을 손에 착 감기는 11.9cm 디자인 안에. 솔직히 돈 더 있으면 iPhone 14 Pro.", price: 650000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-se-midnight-witb-202203?wid=380&hei=784&fmt=jpeg&qlt=90&.v=1644951336059", detailWebURLString: "https://www.apple.com/kr/iphone-se/")
            ])
        let iPad = ProductsCategory(
            name: "iPad",
            imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-comp-air-202210?wid=338&hei=386&fmt=jpeg&qlt=90&.v=1664411153129",
            products: [
                Product(name: "iPad Pro", description: "압도적인 성능. 초고속 무선 연결. 궁극의 iPad 경험", price: 1249000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-comp-pro-202210?wid=338&hei=386&fmt=jpeg&qlt=90&.v=1664411153112", detailWebURLString: "https://www.apple.com/kr/ipad-pro/"),
                Product(name: "iPad Air", description: "얇고 가벼운 디자인. 결코 가볍지 않은 성능", price: 929000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-comp-air-202210?wid=338&hei=386&fmt=jpeg&qlt=90&.v=1664411153129", detailWebURLString: "https://www.apple.com/kr/ipad-air/"),
                Product(name: "iPad", description: "다양한 일상 작업에 맞는 완전히 새롭고, 컬러풀한 iPad", price: 679000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-comp-10thgen-202210?wid=338&hei=386&fmt=jpeg&qlt=90&.v=1664411152951", detailWebURLString: "https://www.apple.com/kr/ipad-select/"),
                Product(name: "iPad mini", description: "한 손에 쏙 들어오는 손색없는 iPad 경험.", price: 769000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-comp-mini-202210?wid=338&hei=386&fmt=jpeg&qlt=90&.v=1664411153122", detailWebURLString: "https://www.apple.com/kr/ipad-mini/")
            ])
        productCategories = [iPhone, iPad]
        
        allProducts = [
            Product(name: "iPhone 14 Pro", description: "항공우주 등급 티타늄 디자인을 갖춘 최초의 iPhone. 게임의 판도를 바꾸는 A17 Pro 칩. 맞춤형 ‘동작’ 버튼. iPhone 사상 가장 강력한 카메라 시스템. 여기에 초고속 전송 속도를 자랑하는 USB 3 규격 USB-C까지.*", price: 1550000, imageURLString: "https://www.apple.com/kr/iphone-15-pro/a/images/overview/closer-look/all_colors__eppfcocn9mky_small_2x.jpg", detailWebURLString: "https://www.apple.com/kr/iphone-15-pro/"),
            Product(name: "iPhone 14", description: "iPhone 15 Pro보다는 떨어지지만 그에 못지 않는 성능. Dynamic 어쩌구. 초고해상도 사진 어쩌구. 컬러 인퓨즈 글래스, 알루미늄 디자인.", price: 1250000, imageURLString: "https://www.apple.com/v/iphone-15/a/images/overview/contrast/iphone_15__dozjxuchowcy_small_2x.jpg", detailWebURLString: "https://www.apple.com/kr/iphone-15/"),
            Product(name: "iPhone 13", description: "이거 그린이 예쁜. 설명할 때 ~입니다로 안 끝나고 ~한, ~은으로 끝나는건 어디서 배워먹은?", price: 950000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-mini-green-witb-202203?wid=328&hei=784&fmt=jpeg&qlt=90&.v=1644964732550", detailWebURLString: "https://www.apple.com/kr/shop/buy-iphone/iphone-13"),
            Product(name: "iPhone SE", description: "놀라운 성능. 합리적인 선택. 이 모든 것을 손에 착 감기는 11.9cm 디자인 안에. 솔직히 돈 더 있으면 iPhone 14 Pro.", price: 650000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-se-midnight-witb-202203?wid=380&hei=784&fmt=jpeg&qlt=90&.v=1644951336059", detailWebURLString: "https://www.apple.com/kr/iphone-se/"),
            Product(name: "iPad Pro", description: "압도적인 성능. 초고속 무선 연결. 궁극의 iPad 경험", price: 1249000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-comp-pro-202210?wid=338&hei=386&fmt=jpeg&qlt=90&.v=1664411153112", detailWebURLString: "https://www.apple.com/kr/ipad-pro/"),
            Product(name: "iPad Air", description: "얇고 가벼운 디자인. 결코 가볍지 않은 성능", price: 929000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-comp-air-202210?wid=338&hei=386&fmt=jpeg&qlt=90&.v=1664411153129", detailWebURLString: "https://www.apple.com/kr/ipad-air/"),
            Product(name: "iPad", description: "다양한 일상 작업에 맞는 완전히 새롭고, 컬러풀한 iPad", price: 679000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-comp-10thgen-202210?wid=338&hei=386&fmt=jpeg&qlt=90&.v=1664411152951", detailWebURLString: "https://www.apple.com/kr/ipad-select/"),
            Product(name: "iPad mini", description: "한 손에 쏙 들어오는 손색없는 iPad 경험.", price: 769000, imageURLString: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-comp-mini-202210?wid=338&hei=386&fmt=jpeg&qlt=90&.v=1664411153122", detailWebURLString: "https://www.apple.com/kr/ipad-mini/")
        ]
    }
    /// price 세 자리 수 씩 끊기
    func priceString(price: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: price))!
    }
    
    func recommendedProducts(products: [Product]) -> [Product] {
        let allProducts = allProducts
        let recommendedProducts = allProducts.shuffled()
        
        return recommendedProducts.prefix(5).map{$0}
    }
}
