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

    @IBOutlet var response: NSTextView!
    @IBOutlet weak var ComboBox: NSComboBox!

    @IBAction func itemIsSelect(sender: NSComboBoxCell) {
        print("\n")
        print(sender.objectValue)
        

    }

//    var connection : Connection!
    var connectionManager:ConnectionManager!
    var msg:NSData? = nil
    var detailRequestJSON = JSONObject()
    
    
    @IBOutlet weak var searchTextField: NSTextField!
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
    
    @IBAction func startSearchDetails(sender: AnyObject) {
        print("--> Send details \n")
        print(self.detailRequestJSON.convertToString())
        print("\n")
        
        self.connectionManager.makeHTTP_Request(self.detailRequestJSON, url: "https://eexcess-dev.joanneum.at/eexcess-privacy-proxy-1.0-SNAPSHOT/api/v1/recommend/getDetails", httpMethod: ConnectionManager.POST, postCompleted: { (succeeded: Bool, msg: NSData) -> () in
            if(succeeded) {
                dispatch_async(dispatch_get_main_queue(), {
                    self.response.string = String(data: msg, encoding: NSUTF8StringEncoding)!
                    self.msg = msg
                })
            }
            else {
                self.response.string = "Error"
            }
        })
    }

    private func doStuff()
    {
//        let jsonObject : [String:AnyObject] = [
//            "origin":["clientType" : "Swift-Test-Client",
//                "clientVersion" : "0.21",
//                "module" : "OS X Prototype",
//                "userID" : "PDPS-WS2015"],
//            "numResults":4,
//            "contextKeywords": [["text" : "\(recommendation.stringValue)"]]
//        ]
//        connection.post(json.jsonObject, url: "https://eexcess-dev.joanneum.at/eexcess-privacy-proxy-1.0-SNAPSHOT/api/v1/recommend"){ (succeeded: Bool, msg: NSData) -> () in
//            if(succeeded) {
//                dispatch_async(dispatch_get_main_queue(), {
//                    self.response.string = String(data: msg, encoding: NSUTF8StringEncoding)!
//                    self.msg = msg
//                })
//            }
//            else {
//                self.response.string = "Error"
//            }
//        }
        
        let json = JSONObject()
        var attr:[String:AnyObject] = ["clientType":"Swift-Test-Client" as AnyObject,"clientVersion":"0.21" as AnyObject,"module":"OS X Prototype" as AnyObject,"userID":"PDPS-WS2015" as AnyObject]
        let childJSON = JSONObject();childJSON.setKeyValuePairs(attr)
        
        let childJSON2 = JSONObject()
        childJSON2.setKeyValuePair("text", value: "\(recommendation.stringValue)")
        
        attr.removeAll(); attr = ["origin":childJSON.jsonObject,"numResults":5,"contextKeywords":[childJSON2.jsonObject]]
        json.setKeyValuePairs(attr)

        print(json.convertToString())
        
        self.connectionManager.makeHTTP_Request(json, url: "https://eexcess-dev.joanneum.at/eexcess-privacy-proxy-1.0-SNAPSHOT/api/v1/recommend", httpMethod: ConnectionManager.POST, postCompleted: { (succeeded: Bool, msg: NSData) -> () in
                        if(succeeded) {
                            dispatch_async(dispatch_get_main_queue(), {
                                self.response.string = String(data: msg, encoding: NSUTF8StringEncoding)!
                                self.msg = msg
                                self.searchDocumentBags()
                            })
                        }
                        else {
                            self.response.string = "Error"
                        }
                    })
    }
    
    func searchDocumentBags(){
        let json = JSONObject(data: self.msg!)
        var jsons = [[String:AnyObject]]()
        for jsonObject in json.getJSONArray("result")!{
            self.ComboBox.addItemWithObjectValue(jsonObject.getJSONObject("documentBadge")!.convertToString())
                jsons.append(jsonObject.getJSONObject("documentBadge")!.jsonObject)
            
        }
        self.detailRequestJSON.setKeyValuePair("documentBadge", value: jsons)
    }
    
     override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        connection = Connection()
        self.connectionManager = ConnectionManager()
        recommendation.delegate = self
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

