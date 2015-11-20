//
//  ViewController.swift
//  Browser
//
//  Created by Andreas Ziemer on 14.10.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import UIKit

class ViewController: UIViewController,  UIPopoverPresentationControllerDelegate, UITableViewDelegate, BackDelegate
{
    var myWebViewDelegate: WebViewDelegate!
    var myAdressBar: AddressBar!
    var p = DataObjectPersistency()
    var tableViewDataSource = SechTableDataSource()
<<<<<<< Updated upstream
=======
    
    var settingsPers = SettingsPersistency()
    var settings = SettingsModel()
>>>>>>> Stashed changes
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var addressBarTxt: UITextField!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    @IBOutlet weak var myWebView: UIWebView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var favourites = [FavouritesModel]()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        myWebViewDelegate = WebViewDelegate()
        myWebViewDelegate.viewCtrl = self
        myWebView.delegate = myWebViewDelegate
        myAdressBar = AddressBar()
        activityIndicator.hidden = true
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = tableViewDataSource
        
        favourites = p.loadDataObject()
        settings = settingsPers.loadDataObject()
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
        let homeUrl = "http://grassandstones.at/sech-test/"
        let url = myAdressBar.checkURL(homeUrl)
        loadURL(url)
    }
    
    func loadURL(requestURL : String){

        let url = NSURL(string: requestURL)
        let request = NSURLRequest (URL: url!)
        myWebView.loadRequest(request)
        myWebView.scalesPageToFit = true
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
        popover.barButtonItem = sender as? UIBarButtonItem
        popover.delegate = self
        presentViewController(vc, animated: true, completion:nil)
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
    
    
    
    //Load Sechtag that was clicked
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
       // let row = indexPath.row
        
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("PopoverViewController")
        vc.modalPresentationStyle = UIModalPresentationStyle.Popover
        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
        popover.sourceView = tableView.cellForRowAtIndexPath(indexPath)
        popover.sourceRect = (tableView.cellForRowAtIndexPath(indexPath)?.bounds)!
        popover.delegate = self
        presentViewController(vc, animated: true, completion:nil)

        
        //print("Sech Tag:   \(sechTags[row]) ")
    }
    
}

