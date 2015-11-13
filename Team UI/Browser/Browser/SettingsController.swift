//
//  OptionsController.swift
//  Browser
//
//  Created by Andreas Ziemer on 11.11.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import UIKit

class SettingsController: UITableViewController{
    
    @IBOutlet weak var homeSetting: UITableViewCell!
    var settingsModel = SettingsModel()
 
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        homeSetting.detailTextLabel?.text = settingsModel.homeURL
    
    }
    
 }