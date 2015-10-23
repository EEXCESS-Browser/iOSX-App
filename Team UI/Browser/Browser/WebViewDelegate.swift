//
//  WebViewDelegate.swift
//  Browser
//
//  Created by Andreas Ziemer on 16.10.15.
//  Copyright © 2015 drui. All rights reserved.
//

import UIKit


class WebViewDelegate: NSObject, UIWebViewDelegate {
    var html: NSString = "HTML"
    var loadStyles = "var script = document.createElement('link'); script.type = 'text/css'; script.rel = 'stylesheet'; script.href = 'sech.css'; document.getElementsByTagName('body')[0].appendChild(script);"
    
        
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        
        print("start load")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        html = webView .stringByEvaluatingJavaScriptFromString("document.html.innerHTML")!
        print(html)
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
    }
}