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
        //-> !
        // Put call for Request of EEXCESS here!
        
        viewCtrl.mainController.setFinishMethod({(msg:String) -> () in
            print(msg)
            // TODO: To be redesigned! 6
            let ds = self.viewCtrl.tableViewDataSource
            ds.makeLabels(SechModel.instance.sechs)
            for sech in SechModel.instance.sechs{
                print("/n/n\(sech.1.response.convertToString())")
            }
            // TODO: To be redesigned! 8
            self.viewCtrl.tableView.reloadData()
        })
        
        //var response = viewCtrl.mainController.createJSONForRequest(sech, detail: false, pref: [:])
        
        
        viewCtrl.mainController.createJSONForRequest(sech, detail: false, pref: [:])
        
        
        // TODO: To be redesigned! 6
        let ds = viewCtrl.tableViewDataSource
        ds.makeLabels(sech)
        
        // TODO: To be redesigned! 8
        viewCtrl.tableView.reloadData()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {

    }
}