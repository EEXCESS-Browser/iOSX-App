//
//  JSONManager.swift
//  Sech
//
//  Created by Alexander Pöhlmann on 21.10.15.
//  Copyright © 2015 Peter Stoehr. All rights reserved.
//

import Foundation

class JSONManager{
    let origin:JSONObject
    
    init(){
        origin = JSONObject(keyValuePairs: ["clientType":"Swift-Test-Client" as AnyObject,"clientVersion":"0.21" as AnyObject,"module":"OS X Prototype" as AnyObject,"userID":"PDPS-WS2015" as AnyObject])
    }
    
    //----------------------------Query-----------------------------------------------
    /*

    */
    func createRequestJSON(contextKeyWords:[JSONObject],numResults:Int)->JSONObject?{
        let json = JSONObject()
        json.addJSONObject("origin", jsonObject: self.origin)
        json.setKeyValuePair("numResults", value: numResults)
        json.addJSONArray("contextKeywords", jsonArray: contextKeyWords)
        return json
    }
    
    func createContextKeywords(keys:[String])->[JSONObject]?{
        var keyWords = [JSONObject]()
        for key in keys {
            let json = JSONObject()
            json.setKeyValuePair("text", value: key)
            keyWords.append(json)
        }
        return keyWords
    }
    
    //----------------------------Query-Details-------------------------------------------------
    
    func createDetailRequest(queryID:String,documentBadge:[[String:AnyObject]])->JSONObject?{
        let json = JSONObject()
        json.addJSONObject("origin", jsonObject: self.origin)
        json.setKeyValuePair("queryID", value: queryID)
        json.setKeyValuePair("documentBadge", value: documentBadge)
        return json
    }
}
