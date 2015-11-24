//
//  SechModel.swift
//  Browser
//
//  Created by Brian Mairhörmann on 21.10.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import Foundation

class SechModel{
    static let instance = SechModel()
    
    var sechs = [String:Sech]()
}

class Sech{
    static let LINK_TAG = "LINK"
    static let SECTION_TAG = "SECTION"
    static let HEAD_TAG = "HEAD"
    
    var id = String()
    var response:JSONObject?//Tbd
    var detail = JSONObject() // Tbd
    var tags = [String : Tag]() // String is id (link, section, head) and Tag is Tag-Object
    var filters = Filter()
}

class Tag {
    var topic = String()
    var type = String()
    var isMainTopic = false
}

class Filter{
    var mediaType = String()
    var provider = String()
    var licence = String()
}
