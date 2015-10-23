//
//  PreferencesViewController.swift
//  Sech
//
//  Created by Tim Stephan Pohrer on 23.10.15.
//  Copyright © 2015 Peter Stoehr. All rights reserved.
//


import Cocoa

class PreferencesViewController: NSViewController, NSTextFieldDelegate {

    
    @IBOutlet weak var ageTextField: NSTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPreferences()
        
        
        
    }
    
    
    func loadPreferences(){
    
        let preferences = NSUserDefaults.standardUserDefaults()
        
        
        
    
    }
    
    @IBAction func savePreferences(sender: NSButton) {
        
        
        
    }
    
    
}