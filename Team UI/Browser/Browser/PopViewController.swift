//
//  PopViewController.swift
//  Browser
//
//  Created by Andreas Netsch on 04.11.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import UIKit




class PopViewController : UIViewController{
    
    
//    @IBOutlet weak var sechText: UITextView!
    
    @IBOutlet weak var sechHeadline: UILabel!
    @IBOutlet weak var sechImage: UIImageView!
    @IBOutlet weak var sechWebView: UIWebView!
    
    @IBAction func openTable(sender: AnyObject) {
//        var popoverContent = (self.storyboard?.instantiateViewControllerWithIdentifier("SearchTableViewController"))! as UIViewController
//        var nav = UINavigationController(rootViewController: popoverContent)
//        nav.modalPresentationStyle = UIModalPresentationStyle.Popover
//        var popover = nav.popoverPresentationController
//        popoverContent.preferredContentSize = CGSizeMake(500,600)
//       // popover!.delegate = self.view
//        popover!.sourceView = self.view
//        popover!.sourceRect = CGRectMake(100,100,0,0)
//        
//        self.presentViewController(nav, animated: true, completion: nil)
        let popoverContent = (self.storyboard?.instantiateViewControllerWithIdentifier("SearchTableViewController"))! as UIViewController
        
        popoverContent.modalPresentationStyle = .Popover
        var popover = popoverContent.popoverPresentationController
        
        if let popover = popoverContent.popoverPresentationController {
            
            let viewForSource = sender as! UIView
            popover.sourceView = viewForSource
            
            // the position of the popover where it's showed
            popover.sourceRect = viewForSource.bounds
            
            // the size you want to display
            popoverContent.preferredContentSize = CGSizeMake(200,500)
//            popover.delegate = self.view
        }
        
        self.presentViewController(popoverContent, animated: true, completion: nil)
    }
    
    var headLine : String!
    var jsonText : String!
    var url : String!
    var searchTags : [EEXCESSSingleResponse]!
    
    override func viewDidLoad() {
        
        for var i = 0  ; i < searchTags.count ; i++ {
            print(searchTags[i].uri)
            }
        
//        let requesturl = NSURL(string: url)
//        let request = NSURLRequest(URL: requesturl!)

        sechHeadline.text = headLine
//            sechText.text = jsonText

//        sechWebView.loadRequest(request)
        
        
    }
    
    
    @IBOutlet weak var SechTitle: UILabel!
    

    func setDetailsInSechView(){
        
    }
    

}
