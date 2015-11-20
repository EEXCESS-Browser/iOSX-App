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
    @IBOutlet weak var ageSetting: UITableViewCell!
    @IBOutlet weak var genderSetting: UITableViewCell!
    @IBOutlet weak var countrySetting: UITableViewCell!
    @IBOutlet weak var citySetting: UITableViewCell!
    @IBOutlet weak var languageSetting: UITableViewCell!
    
    
    
    var settingsModel = SettingsModel()
 
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        homeSetting.detailTextLabel?.text = settingsModel.homeURL
        ageSetting.detailTextLabel?.text = String(settingsModel.age)
        genderSetting.detailTextLabel?.text = settingsModel.gender
        countrySetting.detailTextLabel?.text = settingsModel.country
        citySetting.detailTextLabel?.text = settingsModel.city
        languageSetting.detailTextLabel?.text = settingsModel.language
    
    }
    
 }