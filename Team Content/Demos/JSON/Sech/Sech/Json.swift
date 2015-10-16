//
//  Json.swift
//  Sech
//
//  Created by Alexander Pöhlmann on 16.10.15.
//  Copyright © 2015 Peter Stoehr. All rights reserved.
//

import Foundation

class JSON{
    
    var jsonObject:[String:AnyObject]
    
    init(){
        jsonObject = [String:AnyObject]()
    }
    
    init(data:NSData){
        jsonObject = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as! [String : AnyObject]
    }
    
    init(data:[String:AnyObject]){
        self.jsonObject = data
    }
    
    /**
        method don t search in childObjects
    */
    func found(key:String)->Bool{
        return (jsonObject[key] != nil)
    }
//  --------------------------------------------- search-methods
    func getInt(key:String)->Int?{
        return jsonObject[key] as? Int
    }
    
    func getBool(key:String)->Bool?{
        return jsonObject[key] as? Bool
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
//    ------------------------------------------- /search-methods
//    ------------------------------------------- build-methods
    
    
    func setKeyValuePair(key:String,value:AnyObject)->Bool{
        jsonObject[key] = value
        if jsonObject[key] != nil{
            return true
        }else{
            return false
        }
    }
    
//    ------------------------------------------- /build-methods
//    ------------------------------------------- convert-methods
    
    func convertToString()->String{
        let data = convertToNSData()
        if data == nil{
            return "JSON is empty"
        }else{
            return String(data: data!, encoding: NSUTF8StringEncoding)!
        }
    }
    
    func convertToNSData()->NSData?{
        let data = try? NSJSONSerialization.dataWithJSONObject(self.jsonObject as AnyObject, options: [NSJSONWritingOptions()])
        return data
    }
}

