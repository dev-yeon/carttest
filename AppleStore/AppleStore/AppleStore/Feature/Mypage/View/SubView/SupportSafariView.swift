//
//  SupportSafariView.swift
//  AppleStore
//
//  Created by dayexx on 2023/09/05.
//

import SwiftUI
import SafariServices

struct SupportSafariView : UIViewControllerRepresentable{
  
    @State var siteURL : String
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return SFSafariViewController(url: URL(string:siteURL)!)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
