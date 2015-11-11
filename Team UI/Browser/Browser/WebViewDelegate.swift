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
    var mURL : String = ""
    var viewCtrl: ViewController!
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        // TODO: Analyse Head an Body and create Sechobjects biatches
        let htmlBody = webView .stringByEvaluatingJavaScriptFromString("document.body.innerHTML")!
        let sechTags = regex.findSechTags(inString: htmlBody as String)
        
        mURL = (webView.request?.URL?.absoluteString)!
        print(mURL)
        viewCtrl.addressBarTxt.text = mURL
        
    
        //Teststuff START
        print(sechTags.count)
        
        for item in sechTags{
            let temp = regex.getAttributes(inString: item)
            for x in temp{
                print(x)
            }
            print("------")
        }
        //Teststuff END
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("error")
    }
}