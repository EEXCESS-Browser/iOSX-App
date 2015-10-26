//
//  ViewController.swift
//  Sech
//
//  Created by Peter Stoehr on 29.08.15.
//  Copyright © 2015 Peter Stoehr. All rights reserved.
//

import Cocoa


class ViewController: NSViewController, NSTextFieldDelegate {

    @IBOutlet weak var recommendation: NSTextField!
    //
    @IBOutlet var response: NSTextView!
    @IBOutlet var detailView: NSTextView!
    @IBOutlet weak var ComboBox: NSComboBox!

    //Show select documentbag
    @IBAction func itemIsSelect(sender: NSComboBoxCell) {
        print("\n")
        print(sender.objectValue)
        self.detailRequestJSON.setKeyValuePair("documentBadge", value: [sender.objectValue!])
    }

    var connectionManager:ConnectionManager!
    var msg:NSData? = nil
    var detailRequestJSON = JSONObject()
    let JSON_MANAGER = JSONManager()
    
    let MAINCONTROLLER = MainController()
    
    
    @IBOutlet weak var searchTextField: NSTextField!
    
    //searchfield button action
    @IBAction func searchInJSON(sender: AnyObject) {
        if self.searchTextField.stringValue != "" {
            print((JSONObject(data: self.msg!).getJSONArray("partnerResponseState")![0]).getBool(self.searchTextField.stringValue))
        }
    }
    @IBAction func returnPressed(sender: AnyObject) {
        doStuff()
    }
    
    @IBAction func DoIt(sender: NSButtonCell) {
        doStuff()
    }
    // action click on detail search
    @IBAction func startSearchDetails(sender: AnyObject) {
        print("--> Send details \n")
        print("\n")
        
        if let json = self.MAINCONTROLLER.createJSONForRequest(["json":self.MAINCONTROLLER.mapOfJSONs["\(recommendation.stringValue)"]!], detail: true){
            self.MAINCONTROLLER.makeRequest(json, detail: true)
        }
    }

    private func doStuff()
    {
        if let jsonT = self.MAINCONTROLLER.createJSONForRequest(["numResults":5,"ContextKeywords":["text":"\(recommendation.stringValue)"]],detail: false){
            self.MAINCONTROLLER.makeRequest(jsonT, detail: false)
        }
        
    }
    
     override func viewDidLoad() {
        super.viewDidLoad()
        self.connectionManager = ConnectionManager()
        
        self.MAINCONTROLLER.setMethodForResponse({ (succeeded: Bool, msg: NSData) -> () in
            if(succeeded) {
                dispatch_async(dispatch_get_main_queue(), {
                    self.response.string = String(data: msg, encoding: NSUTF8StringEncoding)!
                    self.msg = msg
                    self.MAINCONTROLLER.mapOfJSONs["\(self.recommendation.stringValue)"] = JSONObject(data: msg)
                })
            }
            else {
                self.response.string = "Error"
            }
        })
        self.MAINCONTROLLER.setMethodForDetaileResponce({(succeeded: Bool, msg: NSData) -> () in
            if(succeeded)
                {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.detailView.string = String(data: msg, encoding: NSUTF8StringEncoding)!
                        self.msg = msg
                    })
            }
            else {
                self.response.string = "Error"
            }
        })
        // Do any additional setup after loading the view.
        
        
        recommendation.delegate = self
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
}

