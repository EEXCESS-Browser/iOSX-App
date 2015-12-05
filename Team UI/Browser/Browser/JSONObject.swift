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
    
    /**
        method don t search in childObjects
    */
    func found(key:String)->Bool{
        
        return (jsonObject[key] != nil)
    }
    
//  --------------------------------------------- search-methods
    func get(key:String)->AnyObject?{
        
        return jsonObject[key]
    }
    
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
            return JSONObject(keyValuePairs: data!)
        }else{
            return nil
        }
        
    }
    
    func getJSONArray(key:String)->[JSONObject]?{
        var list = [JSONObject]()
        let data = (jsonObject[key] as? [[String:AnyObject]])
        if data != nil{
            for single in data!{
                list.append(JSONObject(keyValuePairs: single))
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
    
    func addJSONObject(key:String,jsonObject:JSONObject)->Bool{
        return self.setKeyValuePair(key, value: jsonObject.jsonObject)
    }
    
    func addJSONArray(key:String,jsonArray:[JSONObject])->Bool{
        var jsonAsDict = [[String:AnyObject]]()
        for json in jsonArray{
            jsonAsDict.append(json.jsonObject)
        }
        self.jsonObject[key] = jsonAsDict
        return true
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

//Kopiert von SechQueryComposer
enum JSONData {
    case JSONObject([String:JSONData])
    case JSONArray([JSONData])
    case JSONString(String)
    case JSONNumber(NSNumber)
    case JSONBool(Bool)
    
    var object : [String : JSONData]? {
        switch self {
        case .JSONObject(let aData):
            return aData
        default:
            return nil
        }
    }
    
    var array : [JSONData]? {
        switch self {
        case .JSONArray(let aData):
            return aData
        default:
            return nil
        }
    }
    
    var string : String? {
        switch self {
        case .JSONString(let aData):
            return aData
        default:
            return nil
        }
    }
    
    var integer : Int? {
        switch self {
        case .JSONNumber(let aData):
            return aData.integerValue
        default:
            return nil
        }
    }
    
    var bool: Bool? {
        switch self {
        case .JSONBool(let value):
            return value
        default:
            return nil
        }
    }
    
    subscript(i: Int) -> JSONData? {
        get {
            switch self {
            case .JSONArray(let value):
                return value[i]
            default:
                return nil
            }
        }
    }
    
    subscript(key: String) -> JSONData? {
        get {
            switch self {
            case .JSONObject(let value):
                return value[key]
            default:
                return nil
            }
        }
    }
    
    static func fromObject(object: AnyObject) -> JSONData? {
        switch object {
        case let value as String:
            return JSONData.JSONString(value as String)
        case let value as NSNumber:
            return JSONData.JSONNumber(value)
        case let value as NSDictionary:
            var jsonObject: [String:JSONData] = [:]
            for (key, value) : (AnyObject, AnyObject) in value {
                if let key = key as? String {
                    if let value = JSONData.fromObject(value) {
                        jsonObject[key] = value
                    } else {
                        return nil
                    }
                }
            }
            return JSONData.JSONObject(jsonObject)
        case let value as NSArray:
            var jsonArray: [JSONData] = []
            for v in value {
                if let v = JSONData.fromObject(v) {
                    jsonArray.append(v)
                } else {
                    return nil
                }
            }
            return JSONData.JSONArray(jsonArray)
        default:
            return nil
        }
    }
    
}

