//
//  QueryJSONManager.swift
//  Browser
//
//  Created by Alexander Pöhlmann on 20.11.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import Foundation

class QueryJSONManager {
    
        let origin:JSONObject
        let numResults = 5
    
    init(){
        origin = JSONObject(keyValuePairs: ["clientType":"Swift-Test-Client" as AnyObject,"clientVersion":"0.50" as AnyObject,"module":"OS X Prototype Content" as AnyObject,"userID":"HAW-WS2015-MC5" as AnyObject])
    }
    
    func createRequestJSON(sechs:[String:Sech],preferences:[String:String])->JSONObject{
        let json = JSONObject()
        var queryID = ""
        json.setKeyValuePair("contextKeywords", value: convertSechForRequest(sechs,queryID: &queryID))
        json.setKeyValuePair("queryID", value: queryID)
        json.addJSONObject("origin", jsonObject: self.origin)
        json.setKeyValuePair("numResults", value: numResults)
        return json
    }
    
    private func convertSechForRequest(sechs:[String:Sech], inout queryID:String)->[[[String:AnyObject]]]{
        var contextKeywords = [[[String:AnyObject]]]()
        for sech in sechs{
            var singlekeyword = [[String:AnyObject]]()
            for tags in sech.1.tags {
                var singleOne = [String:AnyObject]()
                singleOne.removeAll()
                
                if tags.1.topic != "" && tags.1.type != "" {
                    singleOne["text"] = tags.1.topic
                    singleOne["type"] = tags.1.type
                    singleOne["isMainTopic"] = tags.1.isMainTopic
                    queryID += "[\(tags.1.topic)]"
                    singlekeyword.append(singleOne)
                }
            }
        contextKeywords.append(singlekeyword)
        }
        return contextKeywords
    }
    
}

class DetailQueryJSONManager{
    
}