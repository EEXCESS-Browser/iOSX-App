//
//  WebViewDelegate.swift
//  Browser
//
//  Created by Andreas Ziemer on 16.10.15.
//  Copyright © 2015 drui. All rights reserved.
//

import UIKit


class WebViewDelegate: NSObject, UIWebViewDelegate {
    
    var regex = Regex()
    var html: NSString = "HTML"    
        
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("true")
        return true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        print("start load")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        html = webView .stringByEvaluatingJavaScriptFromString("document.body.innerHTML")!
        let sechTags = regex.findSechTagsInBody(inString: html as String)
        
        //Teststuff START
        print(sechTags.count)
        
        for item in sechTags{
            print(regex.isSechSection(inString: item))
        }
        //Teststuff END
        print("done")
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("error")
        
        // https://www.google.de/webhp?hl=de&q=yxc#hl=de&q=
    }
}