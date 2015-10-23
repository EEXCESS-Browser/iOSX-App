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
        print(self.detailRequestJSON.convertToString())
        print("\n")
        
        self.connectionManager.makeHTTP_Request(self.detailRequestJSON, url: PROJECT_URL.GETDETAILS, httpMethod: ConnectionManager.POST, postCompleted: { (succeeded: Bool, msg: NSData) -> () in
            if(succeeded) {
                dispatch_async(dispatch_get_main_queue(), {
                    self.detailView.string = String(data: msg, encoding: NSUTF8StringEncoding)!
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
        self.MAINCONTROLLER.setKeyWords([["text":"\(recommendation.stringValue)"]])
        
        
        let contextKeyWords = JSON_MANAGER.createContextKeywords(["text":"\(recommendation.stringValue)"])
        let json = JSON_MANAGER.createRequestJSON(contextKeyWords!,numResults: 5)

        self.connectionManager.makeHTTP_Request(json!, url: PROJECT_URL.RECOMMEND, httpMethod: ConnectionManager.POST, postCompleted: { (succeeded: Bool, msg: NSData) -> () in
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

        let queryID:String = json.getString("queryID")!
        self.detailRequestJSON = JSON_MANAGER.createDetailRequest(queryID, documentBadge: jsons)!
    }
    
     override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.connectionManager = ConnectionManager()
        recommendation.delegate = self
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

