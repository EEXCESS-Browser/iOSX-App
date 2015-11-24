//
//  ResponseJSONManager.swift
//  Browser
//
//  Created by Alexander Pöhlmann on 20.11.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import Foundation

class ResponseJSONManager {
    
    
    init(){
        
    }
    
    func sortRecommend(json:JSONObject){
        for sech in SechModel.instance.sechs{
            for result in json.getJSONArray("results")! {
                let ljson = JSONObject()
                var array = [JSONObject]()
                for singleResult in result.getJSONArray("result")!{
                    let str = singleResult.getString("generatingQuery")
                    let str2 = sech.1.tags["link"]!.topic
                    print("/n\(str!)/n Tag\(str2)")
                    if let hasKey = singleResult.getString("generatingQuery")?.rangeOfString((sech.1.tags["link"]!.topic)){
                        array.append(singleResult)
                        print("\nFound:\n\(singleResult.convertToString())")
                    }
                }
                ljson.addJSONArray("result", jsonArray: array)
                SechModel.instance.sechs[sech.0]?.response = ljson
            }
        }
    }
}

class DetailResponseJSONManager{
    
}