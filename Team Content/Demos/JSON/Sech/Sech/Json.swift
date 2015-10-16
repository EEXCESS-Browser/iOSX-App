//
//  Json.swift
//  Sech
//
//  Created by Alexander Pöhlmann on 16.10.15.
//  Copyright © 2015 Peter Stoehr. All rights reserved.
//

import Foundation

class JSON{
    
    let jsonObject : [String:AnyObject]
    
    init(data:NSData){
        jsonObject = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as! [String : AnyObject]
    }
    
    init(data:[String:AnyObject]){
        self.jsonObject = data
    }
    
    func found(key:String)->Bool{
        return (jsonObject[key] != nil)
    }
    
    func getInt(key:String)->Int?{
        return jsonObject[key] as? Int
    }
    
    func getString(key:String)->String?{
        return jsonObject[key] as? String
    }
    
    func getJSONObject(key:String)->JSON?{
        let data = jsonObject[key] as? [String : AnyObject]
        if data != nil {
            return JSON(data: data!)
        }else{
            return nil
        }
        
    }
    
    func getJSONArray(key:String)->[JSON]?{
        var list = [JSON]()
        let data = (jsonObject[key] as? [[String:AnyObject]])
        if data != nil{
            for single in data!{
                list.append(JSON(data: single))
            }
        }
        return list
    }
    
    
    
    
}

