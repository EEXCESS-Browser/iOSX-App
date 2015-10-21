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
    var tagList: NSString = "HTML"
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        print("start load")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        // TODO: Funktion für Sechanalyse in Swift schreiben.
        // Evtl -> warum funzt Javascript nicht?
        html = webView .stringByEvaluatingJavaScriptFromString("document.getElemtsByTagName(\"b\").innerHTML")!
        tagList = webView .stringByEvaluatingJavaScriptFromString("document.getElementsByTagName(\"b\")")!
        
        print(html)
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
    }
}