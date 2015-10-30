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
    @IBOutlet weak var maleRadioButton: NSButton!
    @IBOutlet weak var femaleRadioButton: NSButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPreferences()
        
        
        
    }
    
    
    func loadPreferences(){
    
    
    }
    
    @IBAction func savePreferences(sender: NSButton) {
        
        
        
    }
    
    
}