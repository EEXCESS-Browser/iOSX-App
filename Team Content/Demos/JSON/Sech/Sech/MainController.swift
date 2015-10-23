//
//  MainController.swift
//  Sech
//
//  Created by Alexander Pöhlmann on 23.10.15.
//  Copyright © 2015 Peter Stoehr. All rights reserved.
//

import Foundation

protocol MainController_P{
    init()
    func setKeyWords(keyWordsWithKeys:[String:[String:String]])->Bool;
    func getResult()->[JSONObject]
    func getDetailResult()->[JSONObject]
    
    func setMethodForResponse(postCompleted :(succeeded: Bool, data: NSData) -> ())->Bool
    func setMethodForDetaileResponce(postCompleted :(succeeded: Bool, data: NSData) -> ())->Bool
}

class MainController:MainController_P{
    let JSONMANAGER:JSONManager
    let CONNECTIONMANAGER:ConnectionManager
    
    required init(){
        self.CONNECTIONMANAGER = ConnectionManager()
        self.JSONMANAGER = JSONManager()
    }
    
    func setKeyWords(keyWordsWithKeys:[String:[String:String]])->Bool{
        return false
    }
    func getResult()->[JSONObject]{
        return [JSONObject]()
    }
    func getDetailResult()->[JSONObject]{
        return [JSONObject]()
    }
    
    func setMethodForResponse(postCompleted :(succeeded: Bool, data: NSData) -> ())->Bool{
        return false
    }
    func setMethodForDetaileResponce(postCompleted :(succeeded: Bool, data: NSData) -> ())->Bool{
        return false
    }
    
    private func makeRequest(json:JSONObject,url:String)->Bool{
        return  false
    }
}
