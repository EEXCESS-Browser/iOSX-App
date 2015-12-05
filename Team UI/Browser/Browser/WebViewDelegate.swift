//
//  WebViewDelegate.swift
//  Browser
//
//  Created by Andreas Ziemer on 16.10.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import UIKit

class WebViewDelegate: NSObject, UIWebViewDelegate {
    
    let regex = RegexForSech()
    let sechManager = SechManager()
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
        
        let finishMethod = ({(msg:String,data:SechPage) -> () in
            print(msg)
            // TODO: To be redesigned! 6
            let ds = self.viewCtrl.tableViewDataSource
            ds.makeLabels(data.sechs)
            for sech in data.sechs{
                print("\n\(sech.0)\n\(data.responses[sech.0])")/*sech.1.getFirstSingleResponseObject()?.getString()*/
            }
            // TODO: To be redesigned! 8
            self.viewCtrl.tableView.reloadData()
            self.viewCtrl.sechModel.sechpages[self.mURL] = data
        })
        
        let data = SechPage(sechs: sech)
        let task = TaskManager(finishMethod: finishMethod, data: data)
        task.delegate(isDetailRequest: false)
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {

    }
}