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

class Sech {
    static let LINK_TAG = "LINK"
    static let SECTION_TAG = "SECTION"
    static let HEAD_TAG = "HEAD"
    
    var id = String()
    var response = JSONObject()//Tbd
    var responseObject : Response!
    var detail = JSONObject() // Tbd
    var tags = [String : Tag]() // String is id (link, section, head) and Tag is Tag-Object
    var filters = Filter()
}

class Tag {
    var topic = String()
    var type = String()
    var isMainTopic = false
}

class Filter {
    var mediaType = String()
    var provider = String()
    var licence = String()
}

class Response {
    //var id : String!
    let title:String
    let description:String?
    let preViewImage:String?
    //var uri : NSURL!
    let generatingQuery:String
    let documentBadge:DocumentBadge
    
    
    init(documentBadge:DocumentBadge,description:String?,title:String?,preViewImage:String?,generatingQuery:String){
        self.title = title!
        self.description = description
        self.preViewImage = preViewImage
        self.documentBadge = documentBadge
        self.generatingQuery = generatingQuery
    }
    
    func getString()->String{
        return "documentBadge:\(documentBadge.createString())\n\ntitle:\(title)\n\ngeneratingQuery:\(generatingQuery)"

        //return "id:\(id)\ntitle:\(title)\nuri:\(String(uri))\ngeneratingQuery:\(generatingQuery)"
    }
}

class DocumentBadge{
    let provider:String
    let id:String
    let uri:String
    
    init(provider:String,id:String,uri:String){
        self.provider = provider
        self.id = id
        self.uri = uri
    }
    
    init(jsonDocumentBag:JSONObject){
        self.provider = jsonDocumentBag.getString("provider")!
        self.id = jsonDocumentBag.getString("id")!
        self.uri = jsonDocumentBag.getString("uri")!
    }
    
    private func createString()->String{
        return "\(self.id)\n\(self.provider)\n\(self.uri)"
    }
}

class ResultGroup{
    //TODO: ...
}

enum SechMediaType {
    case IMAGE
    //TODO: ...
}
