//
//  PreferenceManager.swift
//  Browser
//
//  Created by Alexander Pöhlmann on 18.11.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import Foundation


class SettingsManager {
    
    func getPreferencesValues(){
        let a = NSUserDefaults.standardUserDefaults().floatForKey("slider_preference")
        print("slider_preference: \(a)")
    }
}