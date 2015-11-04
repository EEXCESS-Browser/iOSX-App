//
//  MainController.swift
//  Sech
//
//  Created by Alexander Pöhlmann on 23.10.15.
//  Copyright © 2015 Peter Stoehr. All rights reserved.
//

import Foundation

class MainController{
    let JSONMANAGER:JSONManager
    let CONNECTIONMANAGER:ConnectionManager
    
    var responseMethod:((succeeded: Bool, data: NSData) -> ())?
    var detaileResponseMethod:((succeeded: Bool, data: NSData) -> ())?
    //normal response have sech-tag name and detaile response have a prefix: "_DETAILE"
    var mapOfJSONs = [String:JSONObject]()
    
    required init(){
        self.CONNECTIONMANAGER = ConnectionManager()
        self.JSONMANAGER = JSONManager()
    }
    
    func createJSONForRequest(keyWordsWithKeys:[String:AnyObject],detail:Bool, pref: [String:String])->JSONObject?{
        var json:JSONObject?
        
        if detail {
            var dataForDetailRequest:[String:AnyObject]
            if let data = (keyWordsWithKeys["json"] as? JSONObject) {
                dataForDetailRequest = createDetailRequest(data)
            }else{
                dataForDetailRequest = createDetailRequest(keyWordsWithKeys["json"] as! [[String:AnyObject]])
            }
            
            json = JSONMANAGER.createDetailRequest(dataForDetailRequest["queryID"] as! String, documentBadge: dataForDetailRequest["documentBadge"] as! [[String:AnyObject]])
        }else{
            
            let num = 0.1
            let gender = pref["gender"]!
            let language = pref["language"]!
            let city = pref["city"]!
            let country = pref["country"]!
            
     

            
            json = JSONMANAGER.createRequestJSON(keyWordsWithKeys["ContextKeywords"] as! [[JSONObject]], numResults: keyWordsWithKeys["numResults"] as! Int!,gender: gender,languages: [JSONObject(keyValuePairs: ["iso2":language,"languageCompetenceLevel":num])],address: JSONObject(keyValuePairs: ["country":country,"city":city]))
        }
        return json
    }
    
    func getFirstItem()->JSONObject{
        for json in self.mapOfJSONs {
            return json.1
        }
        return JSONObject()
    }
    
    func setMethodForResponse(postCompleted :(succeeded: Bool, data: NSData) -> ())->Bool{
        self.responseMethod = postCompleted
        return true
    }
    func setMethodForDetaileResponce(postCompleted :(succeeded: Bool, data: NSData) -> ())->Bool{
        self.detaileResponseMethod = postCompleted
        return true
    }
    
    func makeRequest(json:JSONObject,detail:Bool)->Bool{
        if detail{
            self.CONNECTIONMANAGER.makeHTTP_Request(json, url: PROJECT_URL.GETDETAILS, httpMethod: ConnectionManager.POST, postCompleted: self.detaileResponseMethod!)
        }else{
            self.CONNECTIONMANAGER.makeHTTP_Request(json, url: PROJECT_URL.RECOMMEND, httpMethod: ConnectionManager.POST, postCompleted: self.responseMethod!)
        }
        
        return  true
    }
    func seperateDocumentBages(json:JSONObject)->[[String:AnyObject]]{
        var jsons = [[String:AnyObject]]()
        for jsonObject in json.getJSONArray("result")!{
            jsons.append(jsonObject.getJSONObject("documentBadge")!.jsonObject)
            
        }
        return jsons
    }
    
    private func createDetailRequest(json:JSONObject)->[String:AnyObject]{
        let queryID:String = self.getFirstItem().getString("queryID")!
        return ["queryID":queryID,"documentBadge":[json.jsonObject]]
    }
    private func createDetailRequest(json:[[String:AnyObject]])->[String:AnyObject]{
        let queryID:String = self.getFirstItem().getString("queryID")!
        return ["queryID":queryID,"documentBadge":json]
    }
}
