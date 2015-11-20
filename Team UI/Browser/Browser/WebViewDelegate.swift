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
    var sechManager = SechManager()
    var mURL : String = ""
    var viewCtrl: ViewController!
    var sechTableDataSource = SechTableDataSource()
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        viewCtrl.activityIndicator.hidden = false
        viewCtrl.activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        mURL = (webView.request?.URL?.absoluteString)!
        viewCtrl.addressBarTxt.text = mURL
        
        viewCtrl.activityIndicator.stopAnimating()
        viewCtrl.activityIndicator.hidden = true
        
        let htmlHead = webView .stringByEvaluatingJavaScriptFromString("document.head.innerHTML")!
        
        let htmlBody = webView .stringByEvaluatingJavaScriptFromString("document.body.innerHTML")!
        
        let sech = sechManager.getSechObjects(htmlHead, htmlBody: htmlBody)
        
        
        print("Sechlinks found: \(sech.count)")
        print("SechlinkIDs:")
        
        for item in sech{
            print(item.0)
        }
        
        // Put call for Request of EEXCESS here!
        sechTableDataSource.makeLabels(sech)
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {

    }
}