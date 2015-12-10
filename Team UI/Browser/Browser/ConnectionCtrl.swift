//
//  ConnectionCtrl.swift
//  Browser
//
//  Created by Burak Erol on 10.12.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import Foundation

class ConnectionCtrl {
    func post(params : AnyObject, url : String,
        postCompleted : (succeeded: Bool, data: NSData) -> ())
    {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [NSJSONWritingOptions()])
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            postCompleted(succeeded: error == nil, data: data!)
        })
        
        
        task.resume()
        
    }
}