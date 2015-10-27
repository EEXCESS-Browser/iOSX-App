//
//  ViewController.swift
//  Sech
//
//  Created by Peter Stoehr on 29.08.15.
//  Copyright © 2015 Peter Stoehr. All rights reserved.
//

import Cocoa


class ViewController: NSViewController, NSTextFieldDelegate {

    @IBOutlet var detailView: NSTextView!
    @IBOutlet weak var ComboBox_Detail: NSComboBox!


    //Show select documentbag
    @IBAction func itemIsSelect(sender: NSComboBoxCell) {
        print("\n")
        print(sender.objectValue)
//        self.detailRequestJSON.setKeyValuePair("documentBadge", value: [sender.objectValue!])
    }

    var msg:NSData? = nil
    
    let MAINCONTROLLER = MainController()
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        //fill KeyWordType ComboBox
        self.ComboBox_TypeOfKeyword.addItemWithObjectValue(JSONManager.CONTEXT_KEYWORDS_MISC)
        self.ComboBox_TypeOfKeyword.addItemWithObjectValue(JSONManager.CONTEXT_KEYWORDS_PERSON)
        self.ComboBox_TypeOfKeyword.addItemWithObjectValue(JSONManager.CONTEXT_KEYWORDS_LOCATION)
        self.ComboBox_TypeOfKeyword.selectItemWithObjectValue(JSONManager.CONTEXT_KEYWORDS_MISC)
//        --------------
        
        self.MAINCONTROLLER.setMethodForResponse({ (succeeded: Bool, msg: NSData) -> () in
            if(succeeded) {
                dispatch_async(dispatch_get_main_queue(), {
                    self.response.string = String(data: msg, encoding: NSUTF8StringEncoding)!
                    self.msg = msg
                    self.MAINCONTROLLER.mapOfJSONs.removeAll()
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
                        self.MAINCONTROLLER.mapOfJSONs["\(self.recommendation.stringValue)_DETAIL"] = JSONObject(data: msg)
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
    
//    -------------------------------------------------Request----------------------------------
    @IBOutlet weak var ComboBox_RequestKeywords: NSComboBox!
    @IBOutlet weak var ComboBox_TypeOfKeyword: NSComboBox!
    @IBOutlet weak var recommendation: NSTextField!
    @IBOutlet var response: NSTextView!
    @IBOutlet weak var checkBoxIsMainTopic: NSButton!
    
    var jsonKeys = [String:JSONObject]()
    
    @IBAction func DoIt(sender: NSButtonCell) {
        doSplit()
    }
    
    @IBAction func sendRequest(sender: AnyObject) {
        var jsons = [JSONObject]()
        for json in jsonKeys{
            jsons.append(json.1)
        }
        if let jsonT = self.MAINCONTROLLER.createJSONForRequest(["numResults":5,"ContextKeywords":jsons],detail: false){
            print("Request:\n\(jsonT)\n")
            self.MAINCONTROLLER.makeRequest(jsonT, detail: false)
        }
    }
    
    @IBAction func changeKeyContext(sender: NSButton) {
        let isTopic:Bool?
        if checkBoxIsMainTopic.state == NSOnState {
            isTopic = true
        }else{
            isTopic = false
        }
        var keyValues:[String:AnyObject] = ["type":self.ComboBox_TypeOfKeyword.stringValue]
        keyValues["isMainTopic"] = isTopic
        jsonKeys[ComboBox_RequestKeywords.stringValue]!.setKeyValuePairs(keyValues)
    }
    
    private func doSplit()
    {
        jsonKeys.removeAll()
        var key = ""
        recommendation.stringValue += ","
        for c in recommendation.stringValue.characters{
            if(c == ","){
                jsonKeys[key] = JSONObject(keyValuePairs: ["text":key])
                key = ""
            }else{
                key.append(c)
            }
        }
        self.ComboBox_RequestKeywords.removeAllItems()
        for key in jsonKeys{
            print("\(key.1)\n")
            self.ComboBox_RequestKeywords.addItemWithObjectValue(key.0)
        }
    }
    
    @IBAction func selectKeyWord(sender: NSComboBox) {
        
    }
    
//    ---------------------------------------------------Detail-Request--------------------------
    
    // action click on detail search
    @IBAction func startSearchDetails(sender: AnyObject) {
        print("--> Send details \n")
        print("\n")
        
        if let json = self.MAINCONTROLLER.createJSONForRequest([:], detail: true){
            print("Detail Request:\n\(json)\n")
            self.MAINCONTROLLER.makeRequest(json, detail: true)
        }
    }
    
}

