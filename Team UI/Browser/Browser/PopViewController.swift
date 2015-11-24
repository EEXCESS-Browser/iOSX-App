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
    
    
    
    override func viewDidLoad() {
        sechHeadline.text = "SechTest"
    }

    @IBOutlet weak var SechTitle: UILabel!
    
    func setDetailsInSechView(){
        
    }
    

}
