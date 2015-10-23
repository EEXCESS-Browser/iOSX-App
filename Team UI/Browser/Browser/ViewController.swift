//
//  ViewController.swift
//  Browser
//
//  Created by Andreas Ziemer on 14.10.15.
//  Copyright © 2015 drui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var myWebViewDelegate: UIWebViewDelegate!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var bookMarkButton: UIBarButtonItem!
    @IBOutlet weak var addressBar: UITextField!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        myWebViewDelegate = WebViewDelegate()
        myWebView.delegate = myWebViewDelegate
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var myWebView: UIWebView!
    
    @IBAction func loadLink(sender: UITextField) {
        let murl = sender.text
        let url = NSURL(string: murl!)
        let request = NSURLRequest(URL: url!)
        myWebView.loadRequest(request)
        myWebView.scalesPageToFit = true
        
    }
    
    @IBAction func reloadButton(sender: AnyObject) {
         myWebView.reload()
    }
    
    @IBAction func forwardButton(sender: AnyObject) {
        myWebView.goForward()
    }

   
    
    @IBAction func backButton(sender: AnyObject) {
        myWebView.goBack()
    }
  
    
    @IBAction func homeBtn(sender: AnyObject) {
        let homeUrl = "https://www.google.de"
        let url = NSURL(string: homeUrl)
        let request = NSURLRequest(URL: url!)
        myWebView.loadRequest(request)
        myWebView.scalesPageToFit = true
        
    }
    
    
}

