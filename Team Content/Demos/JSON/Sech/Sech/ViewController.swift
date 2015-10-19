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


//    var connection : Connection!
    var connectionManager:ConnectionManager!
    var msg:NSData? = nil
    
    @IBOutlet weak var searchTextField: NSTextField!
    @IBAction func searchInJSON(sender: AnyObject) {
        if self.searchTextField.stringValue != "" {
            print((JSON(data: self.msg!).getJSONArray("partnerResponseState")![0]).getBool(self.searchTextField.stringValue))
        }
    }
    @IBAction func returnPressed(sender: AnyObject) {
        doStuff()
    }
    
    @IBAction func DoIt(sender: NSButtonCell) {
        doStuff()
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
        let childJSON = JSONObject();
        
        childJSON.setKeyValuePair("clientType", value: "Swift-Test-Client");
        childJSON.setKeyValuePair("clientVersion", value: "0.21");
        childJSON.setKeyValuePair("module", value: "OS X Prototype");
        childJSON.setKeyValuePair("userID", value: "PDPS-WS2015")
        
        json.setKeyValuePair("origin", value: childJSON.jsonObject)
        json.setKeyValuePair("numResults", value: 1)
        
        let childJSON2 = JSONObject()
        childJSON2.setKeyValuePair("text", value: "\(recommendation.stringValue)")
        json.setKeyValuePair("contextKeywords", value: [childJSON2.jsonObject])
        print(json.convertToString())
        
        self.connectionManager.makeHTTP_Request(json, url: "https://eexcess-dev.joanneum.at/eexcess-privacy-proxy-1.0-SNAPSHOT/api/v1/recommend", httpMethod: ConnectionManager.POST, postCompleted: { (succeeded: Bool, msg: NSData) -> () in
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

