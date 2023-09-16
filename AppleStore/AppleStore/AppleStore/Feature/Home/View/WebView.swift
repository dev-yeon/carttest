////
////  WebView.swift
////  AppleStore
////
////  Created by KangHo Kim on 2023/09/13.
////

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let urlString: String // Add urlString property

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

            let javascriptCode = """
            var aTags = document.getElementsByTagName('a');
            for (var i = 0; i < aTags.length; i++) {
                aTags[i].onclick = function(event) {
                    event.preventDefault();
                };
                aTags[i].style.display = 'none';
            }

            var buttonTags = document.getElementsByTagName('button');
            for (var i = 0; i < buttonTags.length; i++) {
                buttonTags[i].onclick = function(event) {
                    event.preventDefault();
                };
                buttonTags[i].style.display = 'none';
            }
            """
            webView.evaluateJavaScript(javascriptCode, completionHandler: nil)
        }
    }
}
struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(urlString: "https://www.apple.com/kr/iphone-15-pro/")
            .ignoresSafeArea(.all)
    }
}

