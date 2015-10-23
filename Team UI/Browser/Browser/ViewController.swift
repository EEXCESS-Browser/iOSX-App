//
//  ViewController.swift
//  Browser
//
//  Created by Andreas Ziemer on 14.10.15.
//  Copyright © 2015 drui. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myWebViewDelegate: UIWebViewDelegate!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var bookMarkButton: UIBarButtonItem!
    @IBOutlet weak var addressBar: UITextField!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!

    
    let zechTags = ["Oktoberfest","München"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myWebViewDelegate = WebViewDelegate()
        myWebView.delegate = myWebViewDelegate
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
        
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
        print(request)
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
        print(request)
        myWebView.loadRequest(request)
        myWebView.scalesPageToFit = true
        
    }
    //Table View Methods:
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return zechTags.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ZechCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel!.text = zechTags[indexPath.row]
        
        return cell
        
        
    }
    //forward SechTag to other Group
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        print("Zech Tag:   \(zechTags[row]) ")
    }
    
}

