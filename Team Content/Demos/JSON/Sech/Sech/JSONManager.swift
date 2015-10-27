//
//  JSONManager.swift
//  Sech
//
//  Created by Alexander Pöhlmann on 21.10.15.
//  Copyright © 2015 Peter Stoehr. All rights reserved.
//

import Foundation


class JSONManager{
    static let CONTEXT_KEYWORDS_MISC = "misc"
    static let CONTEXT_KEYWORDS_PERSON = "person"
    static let CONTEXT_KEYWORDS_LOCATION = "location"
    
    let origin:JSONObject
    
    init(){
        origin = JSONObject(keyValuePairs: ["clientType":"Swift-Test-Client" as AnyObject,"clientVersion":"0.50" as AnyObject,"module":"OS X Prototype Content" as AnyObject,"userID":"HAW-WS2015-MC5" as AnyObject])
    }
    
    //----------------------------Query-----------------------------------------------
    /*
        create JSON for Request
    */
    func createRequestJSON(contextKeyWords:[JSONObject],numResults:Int)->JSONObject?{
        let json = JSONObject()
        json.addJSONObject("origin", jsonObject: self.origin)
        json.setKeyValuePair("numResults", value: numResults)
        json.addJSONArray("contextKeywords", jsonArray: contextKeyWords)
        return json
    }
    /*
        only use in combination with the method: createRequestJSON
    */
    func createContextKeywords(keysWithKeysOfKeys:[String:String])->[JSONObject]?{
        var keyWords = [JSONObject]()
        for key in keysWithKeysOfKeys {
            let json = JSONObject()
            json.setKeyValuePair(key.0, value: key.1)
            keyWords.append(json)
        }
        return keyWords
    }
    
    //----------------------------Query-Details-------------------------------------------------
    /*
        create JSON for Detail-Request
    */
    func createDetailRequest(queryID:String,documentBadge:[[String:AnyObject]])->JSONObject?{
        let json = JSONObject()
        json.addJSONObject("origin", jsonObject: self.origin)
        json.setKeyValuePair("queryID", value: queryID)
        json.setKeyValuePair("documentBadge", value: documentBadge)
        return json
    }
}

protocol JSONManager_P{
    func createRequestJSON(contextKeyWords:[JSONObject],numResults:Int)->JSONObject?
    func createContextKeywords(keysWithKeysOfKeys:[String:String])->[JSONObject]?
    func createDetailRequest(queryID:String,documentBadge:[[String:AnyObject]])->JSONObject?
}
