//
//  Json.swift
//  Sech
//
//  Created by Alexander Pöhlmann on 16.10.15.
//  Copyright © 2015 Peter Stoehr. All rights reserved.
//

import Foundation

class JSONObject{
    
    var jsonObject:[String:AnyObject]
    
    init(){
        jsonObject = [String:AnyObject]()
    }
    
    init(keyValuePairs:[String:AnyObject]){
        jsonObject = keyValuePairs
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
    
    func getJSONObject(key:String)->JSONObject?{
        let data = jsonObject[key] as? [String : AnyObject]
        if data != nil {
            return JSONObject(data: data!)
        }else{
            return nil
        }
        
    }
    
    func getJSONArray(key:String)->[JSONObject]?{
        var list = [JSONObject]()
        let data = (jsonObject[key] as? [[String:AnyObject]])
        if data != nil{
            for single in data!{
                list.append(JSONObject(data: single))
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
    func setKeyValuePairs(keysValues:[String:AnyObject])->Bool{
        let oldLength = self.jsonObject.count
        for keyValue in keysValues{
            jsonObject[keyValue.0] = keyValue.1
        }
        if oldLength+keysValues.count == jsonObject.count{
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

