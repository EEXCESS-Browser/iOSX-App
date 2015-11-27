//
//  PopViewController.swift
//  Browser
//
//  Created by Andreas Netsch on 04.11.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import UIKit




class PopViewController : UIViewController{
    
    
    @IBOutlet weak var sechText: UITextView!
    
    @IBOutlet weak var sechHeadline: UILabel!
    @IBOutlet weak var sechImage: UIImageView!
    @IBOutlet weak var sechWebView: UIWebView!
    
    
    var headLine : String!
    var jsonText : String!
    var url : String!
    
    override func viewDidLoad() {
        
        let requesturl = NSURL(string: url)
        let request = NSURLRequest(URL: requesturl!)

        sechHeadline.text = headLine
            sechText.text = jsonText
        sechWebView.loadRequest(request)
    }
    
    
    @IBOutlet weak var SechTitle: UILabel!
    

    func setDetailsInSechView(){
        
    }
    

}
