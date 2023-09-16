//
//  ImageWebView.swift
//  AppleStoreAdmin
//
//  Created by woojin Shin on 2023/09/08.
//

import SwiftUI
import WebKit
import SwiftSoup
import SafariServices



// SafariView를 SwiftUI 뷰로 래핑
struct ImageWebView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }
    
    func getJavaScript() {
        let urlString = "https://www.apple.com/kr/shop/buy-iphone/iphone-15"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        do {
            let html = try String(contentsOf: url)
            let doc = try SwiftSoup.parse(html)

            let metaTagsWithName = try doc.select("meta[name=aos-gn-template]")

            for metaTag in metaTagsWithName {
                let content = try metaTag.attr("content")
                    print("Value: \(content)")
                
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        
    }
    
}

//extension WebView {
//    func callJS(_ args: Any = "") {
//        let script = """
//                        var images = document.querySelector("#\\33 850bf70-50b6-11ee-8c3a-852190be9d11-gallery-item-1 > div > div > div");
//                        for (var i = 0; i < images.length; i++) {
//                            images[i].addEventListener('click', function(event) {
//                                window.webkit.messageHandlers.imageClicked.postMessage(event.target.src);
//                            });
//                        }
//                    """
//
//        webView?.evaluateJavaScript(script) { result, error in
//            if let error {
//                print("Error \(error.localizedDescription)")
//                return
//            }
//
//            if result == nil {
//                print("It's void function")
//                return
//            }
//
//            print("Received Data \(result ?? "")")
//        }
//    }
//}

//struct WebView: UIViewRepresentable {
//    let url: URL?
////    @Binding var canGoBack: Bool
//
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        webView.navigationDelegate = context.coordinator
//        return webView
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        if let url = url {
//            let request = URLRequest(url: url)
//            uiView.load(request)
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, WKNavigationDelegate {
//        var parent: WebView
//
//        init(_ parent: WebView) {
//            self.parent = parent
//        }
//
//        // 웹페이지 로딩이 시작될 때 호출
////        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
////            parent.canGoBack = webView.canGoBack
////        }
//
//    }
//
//
//    func getJavaScript() {
//        let urlString = "https://www.apple.com/kr/shop/buy-iphone/iphone-15"
//
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            return
//        }
//
//        do {
//            let html = try String(contentsOf: url)
//            let doc = try SwiftSoup.parse(html)
//
//            let metaTagsWithName = try doc.select("meta[name=aos-gn-template]")
//
//            for metaTag in metaTagsWithName {
//                let content = try metaTag.attr("content")
//                    print("Value: \(content)")
//
//            }
//        } catch {
//            print("Error: \(error.localizedDescription)")
//        }
//
//
//    }
//
//
//}



struct ImageWebView_Previews: PreviewProvider {
    static let webView = ImageWebView(url: URL(string: "https://www.apple.com/kr/shop/buy-iphone/iphone-15")!)
    
    static var previews: some View {
        webView
            .onTapGesture {
                webView.getJavaScript()
            }
        
    }
}
