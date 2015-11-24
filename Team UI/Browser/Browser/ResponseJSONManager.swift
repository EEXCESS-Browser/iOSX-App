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
                if let hasKey = result.getString("generatingQuery")?.rangeOfString(sech.1.id){
                    
                    
                }
            }
        }
        for result in json.getJSONArray("results")! {
                if  let str = findTextKeyWord(result.getJSONArray("result")![0].getString("generatingQuery")!) {
                    let ljson = JSONObject()
                    json.addJSONArray("result", jsonArray: result.getJSONArray("result")!)
                    
                    SechModel.instance.sechs[str]?.response = ljson
                }
        }
    }
    
    private func findTextKeyWord(str:String)->String?{
        for key in SechModel.instance.sechs.keys {
            if let range = str.rangeOfString(key) {
                return key
            }
        }
        return nil
    }
}

class DetailResponseJSONManager{
    
}