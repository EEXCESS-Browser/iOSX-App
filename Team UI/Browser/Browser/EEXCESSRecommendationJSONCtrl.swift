//
//  EEXCESSRecommendationJSON.swift
//  Browser
//
//  Created by Burak Erol on 10.12.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import Foundation

class EEXCESSRecommendationJSONCtrl {
    var jsonObject : [String : AnyObject] = [:]
    
    private func addOrigin ()
    {
        let eInfos = EEXCESSOrigin()
        var originInfo : [String : AnyObject] = [:]
        
        originInfo["clientType"] = eInfos.clientType
        originInfo["clientVersion"] = eInfos.clientVersion
        originInfo["userID"] = eInfos.userID
        originInfo["module"] = eInfos.module
        
        jsonObject["origin"] = originInfo
    }
    
//    private func addMetaInfo()
//    {
//        let mInfos = EEXCESSMetaInfo()
//        //jsonObject["ageRange"] = mInfos.ageRange
//        jsonObject["gender"] = mInfos.gender
//        jsonObject["numResults"] = mInfos.numResult
//    }
    
    private func addKontextKeywords(seachData:[SEACHModel])
    {
        print("seachData \(seachData.first?.tags)")
        var allKWS : [AnyObject] = []
        
        for (var i=0; i<seachData.count; i++)
        {
            var newEntry : [[String : AnyObject]] = [[:], [:], [:]]
            
            
            newEntry[0]["text"] = seachData[i].tags["link"]?.topic
            newEntry[0]["isMainTopic"] = seachData[i].tags["link"]?.isMainTopic
            //newEntry[0]["type"] = seachData[i].tags["link"]?.type
            
            newEntry[1]["text"] = seachData[i].tags["section"]?.topic
            newEntry[1]["isMainTopic"] = seachData[i].tags["section"]?.isMainTopic
            //newEntry[1]["type"] = seachData[i].tags["section"]?.type
            
            newEntry[2]["text"] = seachData[i].tags["head"]?.topic
            newEntry[2]["isMainTopic"] = seachData[i].tags["head"]?.isMainTopic
            //newEntry[2]["type"] = seachData[i].tags["head"]?.type

            allKWS.append(newEntry)
        }
        jsonObject["contextKeywords"] = allKWS
    }
    
    init(seachData:[SEACHModel])
    {
        addOrigin()
        //addMetaInfo()
        addKontextKeywords(seachData)
    }
}

