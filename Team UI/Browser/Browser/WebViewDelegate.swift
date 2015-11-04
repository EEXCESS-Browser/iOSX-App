//
//  WebViewDelegate.swift
//  Browser
//
//  Created by Andreas Ziemer on 16.10.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import UIKit

class WebViewDelegate: NSObject, UIWebViewDelegate {
    
    var regex = RegexForSech()
    var html: NSString = "HTML"
    var mURL : String = ""
    var viewCtrl: ViewController!
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        html = webView .stringByEvaluatingJavaScriptFromString("document.body.innerHTML")!
        let sechTags = regex.findSechTagsInBody(inString: html as String)
        
        mURL = (webView.request?.URL?.absoluteString)!
        print(mURL)
        viewCtrl.addressBar.text = mURL
    
        //Teststuff START
        print(sechTags.count)
        
        for item in sechTags{
            print(regex.isSechSection(inString: item))
        }
        //Teststuff END
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("error")
    }
}