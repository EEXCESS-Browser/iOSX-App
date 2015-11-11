//
//  ViewController.swift
//  Browser
//
//  Created by Andreas Ziemer on 14.10.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,  UIPopoverPresentationControllerDelegate
{
    var myWebViewDelegate: WebViewDelegate!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var addressBar: UITextField!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    @IBOutlet weak var myWebView: UIWebView!
    @IBOutlet weak var tableView: UITableView!

    let sechTags = ["Oktoberfest","München"]
    var favourites = [FavouritesModel]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        myWebViewDelegate = WebViewDelegate()
        myWebViewDelegate.viewCtrl = self
        myWebView.delegate = myWebViewDelegate
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool)
    {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Adressbar
    @IBAction func adressBar(sender: UITextField) {
        loadURL(sender.text!)
         }
    @IBAction func homeBtn(sender: AnyObject){
        let homeUrl = "http://grassandstones.at/sech-test/"
        loadURL(homeUrl)
    }
    
    func loadURL(requestURL : String){
        var checkedURL: String
        if(validateHTTPWWW(requestURL) || validateHTTP(requestURL)){
            checkedURL = requestURL
        }else if(validateWWW(requestURL)){
            checkedURL = "https://" + requestURL
        }else{
            let searchString = requestURL.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
            checkedURL = "https://www.google.de/#q=" + searchString
        }
        
        let url = NSURL(string: checkedURL)
        let request = NSURLRequest (URL: url!)
        myWebView.loadRequest(request)
        myWebView.scalesPageToFit = true
    }

    func validateHTTP (stringURL : NSString) -> Bool
    {
        let urlRegEx = "((https|http)://).*"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[urlRegEx])
        return predicate.evaluateWithObject(stringURL)
    }
    func validateWWW (stringURL : NSString) -> Bool
    {
        let urlRegEx = "((\\w|-)+)(([.]|[/])((\\w|-)+)).*"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[urlRegEx])
        return predicate.evaluateWithObject(stringURL)
    }
    func validateHTTPWWW (stringURL : NSString) -> Bool
    {
        let urlRegEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+)).*"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[urlRegEx])
        return predicate.evaluateWithObject(stringURL)
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
            fav.url = self.addressBar.text!
            
        }

        alertSheetController.addAction(enterAction)
        
        let editBookmarks = UIAlertAction(title: "Lesezeichen verwalten", style: .Default)
        {
                action-> Void in
            
            self.performSegueWithIdentifier("editBookmarks",sender:self)
                
                
        }
        
        alertSheetController.addAction(editBookmarks)
        
        alertSheetController.addTextFieldWithConfigurationHandler
        {
            textField -> Void in
            textField.placeholder="Titel"
        }
        
        alertSheetController.addTextFieldWithConfigurationHandler
        {
                textField -> Void in
                textField.placeholder="URL"
                textField.text = self.addressBar.text
        }

        self.presentViewController(alertSheetController, animated: true) {}
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "editBookmarks"
        {
            let destVC = segue.destinationViewController as! FavouriteTableViewController
            destVC.favourites = favourites
        }
    }
    
    @IBAction func reloadButton(sender: AnyObject)
    {
         myWebView.reload()
    }
    
    @IBAction func forwardButton(sender: AnyObject)
    {
        myWebView.goForward()
    }

    @IBAction func backButton(sender: AnyObject)
    {
        myWebView.goBack()
    }
  
    
 
    @IBAction func doPopover(sender: AnyObject) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("PopoverViewController")
        vc.modalPresentationStyle = UIModalPresentationStyle.Popover
        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
        popover.barButtonItem = sender as! UIBarButtonItem
        popover.delegate = self
        presentViewController(vc, animated: true, completion:nil)
    }

    
    //Table View Methods:
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return sechTags.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("SechCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel!.text = sechTags[indexPath.row]
        
        
        
        return cell
    }
    
    //forward SechTag to other Group
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        
        print("Sech Tag:   \(sechTags[row]) ")
    }
    
}

