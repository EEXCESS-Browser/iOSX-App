//
//  WebViewDelegate.swift
//  Browser
//
//  Created by Andreas Ziemer on 16.10.15.
//  Copyright © 2015 drui. All rights reserved.
//

import UIKit


class WebViewDelegate: NSObject, UIWebViewDelegate {
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        print("start load")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        print("finish load")
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
    }
    
}