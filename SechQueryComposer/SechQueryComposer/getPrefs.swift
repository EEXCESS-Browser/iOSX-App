//
//  getPrefs.swift
//  SechQueryComposer
//
//  Copyright © 2015 Peter Stoehr. All rights reserved.
//

import Foundation

class PreferencesR {

    let defaults = NSUserDefaults.standardUserDefaults()

    var numResults : Int {
        get {
            let v = defaults.integerForKey("numResults")
            if (v < 10) {
                return 10
            }
            return v
        }
        set (gIndex) {
            defaults.setInteger(gIndex, forKey: "numResults")
        }
    }

    var gender : Int {
        get {
            return defaults.integerForKey("gender")
        }
        set (gIndex) {
            defaults.setInteger(gIndex, forKey: "gender")
        }
    }
    
    var age : Int {
        get {
            return defaults.integerForKey("age")
        }
        set (age) {
            defaults.setInteger(age, forKey: "age")
        }
    }
    
    var url : String {
        get {
            let v = defaults.valueForKey("url")
            if (v == nil) {
                return "https://eexcess-dev.joanneum.at/eexcess-privacy-proxy-issuer-1.0-SNAPSHOT/issuer"
            }
            return v as! String
        }
        set (url) {
            var cUrl = url
            if (cUrl[cUrl.endIndex.predecessor()] == "/") {
                cUrl.removeAtIndex(cUrl.endIndex.predecessor())
            }
            
            defaults.setValue(cUrl, forKey: "url")
        }
        
    }
}