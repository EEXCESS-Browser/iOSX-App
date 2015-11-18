//
//  SettingsModel.swift
//  Browser
//
//  Created by Andreas Ziemer on 13.11.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import Foundation

class SettingsModel : NSObject, NSCoding{
    var homeURL: String
    var age: Int

    init(homeURL:String, age:Int){
        self.homeURL = homeURL
        self.age = age
    }
    
    override init(){
        self.homeURL = "http://grassandstones.at/sech-test"
        self.age = 0
    }
    
    required init(coder aCoder:NSCoder){
        homeURL = aCoder.decodeObjectForKey("homeURL") as! String
        age = aCoder.decodeObjectForKey("age") as! Int
    }
    
    func encodeWithCoder(aCoder:NSCoder){
        aCoder.encodeObject(homeURL, forKey:"homeURL")
        aCoder.encodeObject(age, forKey:"age")
    }
}

extension SettingsModel {
    var extHome : String {
        get {
            return homeURL
        }
        set(newURL) {
            homeURL = newURL
        }
    }
    var extAge : Int {
        get {
            return age
        }
        set(newAge){
            age = newAge
        }
    }
}

class SettingsPersistency {
    private let fileName = "settings.plist"
    private let dataKey = "SettingsObj"
    
    func loadDataObject()-> SettingsModel {
        var item : SettingsModel!
        let file = dataFileForName(fileName)
        
        if(!NSFileManager.defaultManager().fileExistsAtPath(file)){
            return SettingsModel()
        }
        if let data = NSData(contentsOfFile: file){
            let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
            item = unarchiver.decodeObjectForKey(dataKey) as! SettingsModel
            unarchiver.finishDecoding()
        }
        return item
    }
    
    func saveDataObject(items: SettingsModel){
        let file = dataFileForName(fileName)
        let data = NSMutableData()
        
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(items, forKey: dataKey)
        archiver.finishEncoding()
        data.writeToFile(file, atomically: true)
    }
    
    private func documentPath() -> String{
        let allPathes = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) 
        return allPathes[0]
    }
    
    private func tmpPath() -> String{
        return NSTemporaryDirectory()
    }
    
    private func dataFileForName(fileName:String)->String
    {
        return (documentPath() as NSString).stringByAppendingPathComponent(fileName)
    }
    
    private func tmpFileForName(fileName:String)->String
    {
        return (tmpPath() as NSString).stringByAppendingPathComponent(fileName)
    }

}