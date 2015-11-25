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
            var array = [JSONObject]()
            
            for result in json.getJSONArray("results")! {
                for singleResult in result.getJSONArray("result")!{
                    //let str = singleResult.getString("generatingQuery")
                    let str2 = sech.1.tags["link"]!.topic
                    if let hasKey = singleResult.getString("generatingQuery")?.rangeOfString((sech.1.tags["link"]!.topic)){
                        array.append(singleResult)
                        print("\nFound:\n\(singleResult.convertToString())in \(str2)")
                        /* create Response Object*/
                        SechModel.instance.sechs[sech.0]!.responseObject = createResponseObject(singleResult)
                        print("\nResponseObject:\n\(SechModel.instance.sechs[sech.0]!.responseObject.getString())")
                    }
                }
            }
            SechModel.instance.sechs[sech.0]!.response.addJSONArray("result", jsonArray: array)
        }
    }
    
    func createResponseObject(singleResult:JSONObject)->Response{
        let singleResponse = Response(documentBadge: DocumentBadge(jsonDocumentBag: singleResult.getJSONObject("documentBadge")!), description: singleResult.getString("generatingQuery"), title: singleResult.getString("title"), preViewImage: singleResult.getString("previewImage"), generatingQuery: singleResult.getString("generatingQuery")!)
        //let documentBadge : JSONObject
        
//        singleResponse.title = singleResult.getString("title")!
//        documentBadge = singleResult.getJSONObject("documentBadge")!
//        singleResponse.id = documentBadge.getString("id")!
//        singleResponse.uri = NSURL(string: (documentBadge.getString("uri"))!)
//        singleResponse.generatingQuery = singleResult.getString("generatingQuery")!
        return singleResponse
        }
    }

class DetailResponseJSONManager{
    
    func sortDetailRecommend(json:JSONObject){
        
    }
    
}