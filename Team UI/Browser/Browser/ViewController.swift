//
//  ViewController.swift
//  Browser
//
//  Created by Andreas Ziemer on 14.10.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController , WKScriptMessageHandler,  UIPopoverPresentationControllerDelegate, UITableViewDelegate, BackDelegate
{
    
    var myWebView: WKWebView?
    
//    override func loadView() {
//        super.loadView()
//        
//        self.myWebView = WKWebView(frame: containerView.bounds)
//        containerView.addSubview(myWebView!)
//        
//
//        
//        
//    }
    
    
    var myWebViewDelegate : WebViewDelegate!
    let myAdressBar: AddressBar = AddressBar()

    let p : DataObjectPersistency = DataObjectPersistency()
    let tableViewDataSource = SechTableDataSource()
//    var p = DataObjectPersistency()
//    var tableViewDataSource = SechTableDataSource()

    
    let settingsPers = SettingsPersistency()
    var settings = SettingsModel()
    let sechModel = SechModel()
    var headLine : String!
    
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var addressBarTxt: UITextField!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
//    @IBOutlet weak var myWebView: UIWebView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var containerView: UIView! = nil
    
    
    var favourites = [FavouritesModel]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        myWebViewDelegate = WebViewDelegate()
        myWebViewDelegate.viewCtrl = self
       
        activityIndicator.hidden = true
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = tableViewDataSource
        
        
        
        //p = DataObjectPersistency()
        settings = settingsPers.loadDataObject()
        

        
        let config = WKWebViewConfiguration()
        let scriptURL = NSBundle.mainBundle().pathForResource("main", ofType: "js")
        let scriptContent = try! String( contentsOfFile: scriptURL!, encoding:NSUTF8StringEncoding)
        let script = WKUserScript(source: scriptContent, injectionTime: .AtDocumentStart, forMainFrameOnly: true)
        config.userContentController.addUserScript(script)

        config.userContentController.addScriptMessageHandler(self, name: "onclick")

      
        
        self.myWebView = WKWebView(frame: containerView.bounds, configuration: config)
        
    }
    
    
    
    override func viewDidAppear(animated: Bool) {

        containerView.addSubview(myWebView!)
         myWebView?.navigationDelegate = myWebViewDelegate

        
    }
    
    func buttonClickEventTriggeredScriptToAddToDocument() ->String{

        var script:String?
        
        if let filePath:String = NSBundle(forClass: ViewController.self).pathForResource("main", ofType:"js") {
            
            script = try? String (contentsOfFile: filePath, encoding: NSUTF8StringEncoding)
        }
        return script!;
        
    }

    
    
    
    override func viewWillAppear(animated: Bool)
    {
        navigationController?.setNavigationBarHidden(true, animated: true)
        favourites = p.loadDataObject()

    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func receiveInfo(ctrl: FavouriteTableViewController, info: FavouritesModel)
    {
        loadURL(info.url)
        ctrl.navigationController?.popToRootViewControllerAnimated(true)
    }


    //Adressbar
    @IBAction func addressBar(sender: UITextField) {
        let url = myAdressBar.checkURL(sender.text!)
        loadURL(url)
         }
    
    @IBAction func homeBtn(sender: AnyObject){
        let homeUrl = settings.homeURL
        let url = myAdressBar.checkURL(homeUrl)
        loadURL(url)
    }
    
    func loadURL(requestURL : String){

        let url = NSURL(string: requestURL)
        let request = NSURLRequest (URL: url!)
        myWebView?.loadRequest(request)

    }
    
    //Adressbar Ende

    @IBAction func favouriteButton(sender: AnyObject)
    {
        let alertSheetController = UIAlertController(title: "Favoriten hinzufügen", message: "Geben Sie den Titel ein", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel)
        {
            action-> Void in
            print("Cancel")
                
        }
        
        alertSheetController.addAction(cancelAction)
        
        let enterAction = UIAlertAction(title: "Enter", style: .Default)
        {
                action-> Void in
            
            let textfield : UITextField = alertSheetController.textFields![0]
            let fav = FavouritesModel()

            self.favourites.append(fav)

            fav.title = textfield.text!
            fav.url = self.addressBarTxt.text!
            
            self.p.saveDataObject(self.favourites)
            
        }

        alertSheetController.addAction(enterAction)
        
        alertSheetController.addTextFieldWithConfigurationHandler
        {
            textField -> Void in
            textField.placeholder="Titel"
        }
        
        alertSheetController.addTextFieldWithConfigurationHandler
        {
                textField -> Void in
                textField.placeholder="URL"
                textField.text = self.addressBarTxt.text
        }

        self.presentViewController(alertSheetController, animated: true) {}
    }
    
    @IBAction func favBtn(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("editBookmarks", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "editBookmarks"
        {
            let destVC = segue.destinationViewController as! FavouriteTableViewController
            destVC.favourites = favourites
            destVC.delegate = self

        }

        
//        if segue.identifier == "PopoverViewController"{
//            let destVC = segue.destinationViewController as! PopViewController
//            destVC.title = "This is From Segue"
//        }

        if segue.identifier == "showPopView"
        {
            let popViewController = segue.destinationViewController as! PopViewController
            popViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            //print("Segue"+self.headLine)
            popViewController.headLine = self.headLine
//            popViewController.jsonText = SechModel.instance.sechs[self.headLine]?.response.convertToString()
//            popViewController.url = SechModel.instance.sechs[self.headLine]?.responseObject.documentBadge.uri
//            if let response = SechPage.instance.sechs[self.headLine]?.getFirstSingleResponseObject(){
//                popViewController.jsonText = response.getString()
//                popViewController.url = response.documentBadge.getURI()
//            }else{
//                popViewController.jsonText = "NO RESULTS"
//                popViewController.url = "https://www.google.de/"
//            }
            if let response = (sechModel.sechpages[self.myWebViewDelegate.mURL]!.responses[self.headLine])?.first{
                popViewController.jsonText = response.getString()
                popViewController.url = response.documentBadge.getURI()
            }else{
                popViewController.jsonText = "NO RESULTS"
                popViewController.url = "https://www.google.de/?gws_rd=ssl#q=Mein+Name+ist+Hase"
            }
            
            popViewController.popoverPresentationController?.delegate = self

        }
    

    }
    
    
    @IBAction func reloadButton(sender: AnyObject)
    {
         myWebView!.reload()
    }
    
    @IBAction func forwardButton(sender: AnyObject)
    {
        myWebView!.goForward()
    }

    @IBAction func backButton(sender: AnyObject)
    {
        myWebView!.goBack()
    }

    @IBAction func doPopover(sender: AnyObject) {
//        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewControllerWithIdentifier("PopoverViewController")
//        vc.modalPresentationStyle = UIModalPresentationStyle.Popover
//        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
//        popover.barButtonItem = sender as? UIBarButtonItem
//        popover.delegate = self
//        presentViewController(vc, animated: true, completion:nil)
    }
    
    
    @IBAction func optionsMenu(sender: UIBarButtonItem) {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("OptionsMenu")
        vc.modalPresentationStyle = UIModalPresentationStyle.Popover
        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
        popover.barButtonItem = sender
        popover.delegate = self
        presentViewController(vc, animated: true, completion:nil)
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        

//        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewControllerWithIdentifier("PopoverViewController")
//        vc.modalPresentationStyle = UIModalPresentationStyle.Popover
//        
//        //vc.prepareForSegue(<#T##segue: UIStoryboardSegue##UIStoryboardSegue#>, sender: <#T##AnyObject?#>)
//        
//        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
//        popover.sourceView = tableView.cellForRowAtIndexPath(indexPath)
//        popover.sourceRect = (tableView.cellForRowAtIndexPath(indexPath)?.bounds)!
//        popover.delegate = self
//        
//        presentViewController(vc, animated: true, completion:nil)
//        
//

        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        
        headLine = (currentCell.textLabel?.text!)! as String
        print("\n\n\n\n\n\n\n")
        print("selected: "+headLine)
        
//        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewControllerWithIdentifier("PopoverViewController")
//        vc.modalPresentationStyle = UIModalPresentationStyle.Popover
//        
//        
//        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
//        popover.sourceView = tableView.cellForRowAtIndexPath(indexPath)
//        popover.sourceRect = (tableView.cellForRowAtIndexPath(indexPath)?.bounds)!
//        popover.delegate = self

        
        
        
        
//        presentViewController(vc, animated: true, completion:nil)
        
        return indexPath
    }
    
    //Load Sechtag that was clicked
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
//    {
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        
//        
//        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
//        
//        headLine = (currentCell.textLabel?.text!)! as String
//        print("\n\n\n\n\n\n\n")
//        print(headLine)
//        
//        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewControllerWithIdentifier("PopoverViewController")
//        vc.modalPresentationStyle = UIModalPresentationStyle.Popover
//        
//
//        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
//        popover.sourceView = tableView.cellForRowAtIndexPath(indexPath)
//        popover.sourceRect = (tableView.cellForRowAtIndexPath(indexPath)?.bounds)!
//        popover.delegate = self
//        
//        
//        
//        
//        presentViewController(vc, animated: true, completion:nil)
//
//        
//  //    print("Sech Tag:   \(sechTags[row]) ")
//    }
    
   
    func userContentController(userContentController: WKUserContentController,
        didReceiveScriptMessage message: WKScriptMessage) {
            print("JavaScript is sending a message \(message.body)")
            self.headLine = message.body as! String
            performSegueWithIdentifier("showPopView", sender: self)
            
          
            
    }

    
}

