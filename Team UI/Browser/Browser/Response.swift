//
//  Response.swift
//  Browser
//
//  Created by Alexander Pöhlmann on 05.12.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import Foundation


class Response {
    //var id : String!
    let title:String
    let description:String?
    let preViewImage:String?
    //var uri : NSURL!
    let generatingQuery:String
    let documentBadge:DocumentBadge
    
    init(result:JSONObject){
        self.documentBadge = DocumentBadge(jsonDocumentBag: result.getJSONObject("documentBadge")!)
        self.title = result.getString("title")!
        self.description = result.getString("generatingQuery")!
        self.generatingQuery = result.getString("generatingQuery")!
        
        self.preViewImage = result.getString("previewImage")
    }
    
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
    
    func getID()->String{
        return self.documentBadge.id
    }
}

class DocumentBadge{
    private let provider:String
    private let id:String
    private let uri:String
    
    private init(provider:String,id:String,uri:String){
        self.provider = provider
        self.id = id
        self.uri = uri
    }
    
    private init(jsonDocumentBag:JSONObject){
        self.provider = jsonDocumentBag.getString("provider")!
        self.id = jsonDocumentBag.getString("id")!
        self.uri = jsonDocumentBag.getString("uri")!
    }
    
    func getURI()->String{
        return self.uri
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