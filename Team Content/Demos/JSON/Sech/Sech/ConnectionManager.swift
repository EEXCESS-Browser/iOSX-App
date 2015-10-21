//
//  ConnectionManager.swift
//  Sech
//
//  Created by Alexander Pöhlmann on 16.10.15.
//  Copyright © 2015 Peter Stoehr. All rights reserved.
//

import Foundation

class ConnectionManager{
    
    static let POST = "POST"
    static let GET = "GET"
    
    let JSON_OPTION = "application/json"
    
    let FOR_HTTP_HEADER_FIELD__CONTENT_TYPE = "Content-Type"
    let FOR_HTTP_HEADER_FIELD__ACCENT = "Accept"
    
    func makeHTTP_Request(data:JSONObject,url:String,httpMethod:String,postCompleted : (succeeded: Bool, data: NSData) -> ()){
        let request = addRequestContent(createRequest(url),httpMethod: httpMethod,data: data.convertToNSData()!)
        self.sendRequest(request, postCompleted: postCompleted)
    }
    
    private func createRequest(url:String)->NSMutableURLRequest{
        return NSMutableURLRequest(URL: NSURL(string: url)!)
    }
    
    private func addRequestContent(request:NSMutableURLRequest,httpMethod:String,data:NSData)->NSMutableURLRequest{
        request.HTTPMethod = httpMethod
        request.addValue(JSON_OPTION, forHTTPHeaderField: FOR_HTTP_HEADER_FIELD__CONTENT_TYPE)
        request.addValue(JSON_OPTION, forHTTPHeaderField: FOR_HTTP_HEADER_FIELD__ACCENT)
        request.HTTPBody = data
        return request
    }
    
    private func sendRequest(request:NSMutableURLRequest,postCompleted : (succeeded: Bool, data: NSData) -> ()){
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            postCompleted(succeeded: error == nil, data: data!)
        })
        
        
        task.resume()
    }
}



class PROJECT_URL {
    static let GETDETAILS = "https://eexcess-dev.joanneum.at/eexcess-privacy-proxy-issuer-1.0-SNAPSHOT/issuer/getDetails"
    static let RECOMMEND = "https://eexcess-dev.joanneum.at/eexcess-privacy-proxy-issuer-1.0-SNAPSHOT/issuer/recommend"
    static let url3 = ""
    static let url4 = ""
}


