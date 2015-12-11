//
//  ResponseJSONManager.swift
//  Browser
//
//  Created by Alexander Pöhlmann on 20.11.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import Foundation

class EEXCESSResponseFilterManager:AbstractResponseFilterManager {
    
    
    override init(){
        
    }
    
    override func delegate(data:NSData,inout storage:SechPage){
        for sech in storage.sechs{
            var array = [Response]()
            
            for result in JSONObject(data: data).getJSONArray("results")! {
                for singleResult in result.getJSONArray("result")!{
                    let str2 = sech.1.tags["link"]!.topic
                    if singleResult.getString("generatingQuery")?.rangeOfString((sech.1.tags["link"]!.topic)) != nil {
                        array.append(Response(result: singleResult))
                      //  print("\nFound:\n\(singleResult.convertToString())in \(str2)")
                    }
                }
            }
            storage.responses[sech.0] = array
        }

    }
    func delegate(json:JSONObject,inout data:SechPage){
        for sech in data.sechs{
            var array = [Response]()
            
            for result in json.getJSONArray("results")! {
                for singleResult in result.getJSONArray("result")!{
                    let str2 = sech.1.tags["link"]!.topic
                    if singleResult.getString("generatingQuery")?.rangeOfString((sech.1.tags["link"]!.topic)) != nil {
                        array.append(Response(result: singleResult))
                        print("\nFound:\n\(singleResult.convertToString())in \(str2)")
                    }
                }
            }
            data.responses[sech.0] = array
        }
    }
}

class DetailResponseJSONManager{
    
    func sortDetailRecommend(json:JSONObject){
        
    }
    
}