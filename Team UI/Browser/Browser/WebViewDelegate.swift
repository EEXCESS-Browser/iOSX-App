//
//  WebViewDelegate.swift
//  Browser
//
//  Created by Andreas Ziemer on 16.10.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import UIKit
import WebKit

class WebViewDelegate: NSObject, WKNavigationDelegate {
    
    let regex = RegexForSech()
    let sechManager = SechManager()
    var mURL : String = ""
    var viewCtrl: ViewController!
    var htmlHead : String = ""
    var htmlBody : String = ""

    
//    func webView(webView: WKWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: WKNavigation) -> Bool {
//        return true
//    }
//    
//    func webViewDidStartLoad(webView: WKWebView) {
//        viewCtrl.activityIndicator.hidden = false
//        viewCtrl.activityIndicator.startAnimating()
//    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        
        
     //   mURL = (webView.request?.URL?.absoluteString)!
     //   viewCtrl.addressBarTxt.text = mURL
        
        viewCtrl.activityIndicator.stopAnimating()
        viewCtrl.activityIndicator.hidden = true
        
        
        // Ineinander verschachtelt, weil completionHandler wartet bis ausgeführt wurde
        
        webView.evaluateJavaScript("document.head.innerHTML", completionHandler: { (object, error) -> Void in
            if error == nil && object != nil{
                self.htmlHead = (object as? String)!
            print("We are in eveluateJavascript")
            
            webView .evaluateJavaScript("document.body.innerHTML", completionHandler: { (object, error) -> Void in
                 if error == nil && object != nil{
                self.htmlBody = (object as? String)!
                    
                    print(self.htmlBody)
                
                let sech = self.sechManager.getSechObjects(self.htmlHead, htmlBody: self.htmlBody)
                
                
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

                    // TODO: To be redesigned! 8
                    self.viewCtrl.tableView.reloadData()
                    self.viewCtrl.sechModel.sechpages[self.mURL] = data
                })
                
                let data = SechPage(sechs: sech)
                let task = TaskManager(finishMethod: finishMethod, data: data)
                task.delegate(isDetailRequest: false)

                
                }
            })
            
            
                            }
        }
        )
            

        
            }
        
    
    func webView(webView: WKWebView, didFailLoadWithError error: NSError?) {

    }
            
        
}