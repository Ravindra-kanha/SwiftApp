//
//  WebView.swift
//  NewsApp
//
//  Created by Apple on 15/09/20.
//  Copyright © 2020 Apple. All rights reserved.

import SwiftUI
import WebKit
import Combine

struct WebView: UIViewRepresentable {
    
    let webView = WKWebView()
    
    //link to load the Link on the WebView.
    var link: String
    
    //didFinishLoading to check the loading is finish or not
    var didFinishLoading: Bool = false
    
    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        
        self.webView.navigationDelegate = context.coordinator
        if let url = URL(string: link){
            DispatchQueue.main.async {
                ActivityIndicator.shared.showOverlay(nil)
            }
            self.webView.load(URLRequest(url: url))
        }
        return self.webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        return
    }
    
    func makeCoordinator() -> WebView.Coordinator {
        Coordinator(self, didFinishLoading: didFinishLoading)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate{
        
        var parent: WebView
        var didFinishLoading: Bool
        
        init(_ parent: WebView, didFinishLoading: Bool) {
            self.parent = parent
            self.didFinishLoading = didFinishLoading
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.didFinishLoading = true
            hideActivityIndicator()
        }
        
        func hideActivityIndicator(){
            DispatchQueue.main.async {
                ActivityIndicator.shared.hideOverlayView()
            }
        }
        
    }
}
