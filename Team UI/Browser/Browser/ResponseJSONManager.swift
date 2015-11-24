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
            var array = [JSONObject]()
            
            for result in json.getJSONArray("results")! {
                for singleResult in result.getJSONArray("result")!{
                    //let str = singleResult.getString("generatingQuery")
                    let str2 = sech.1.tags["link"]!.topic
                    if let hasKey = singleResult.getString("generatingQuery")?.rangeOfString((sech.1.tags["link"]!.topic)){
                        array.append(singleResult)
                        print("\nFound:\n\(singleResult.convertToString())in \(str2)")
                    }
                }
            }
            SechModel.instance.sechs[sech.0]!.response.addJSONArray("result", jsonArray: array)
        }
    }
}

class DetailResponseJSONManager{
    
}