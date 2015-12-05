//
//  TaskManager.swift
//  Browser
//
//  Created by Alexander Pöhlmann on 05.12.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import Foundation

class TaskManager{
    
    private var responseMethod:((succeeded: Bool, msg: NSData) -> ())
    private let finishMethod:((msg:String,data:SechPage) -> ())

    private var sechModel:SechPage

    init(finishMethod:((msg:String,data:SechPage) -> ()),data:SechPage){
        
        self.finishMethod = finishMethod
        self.sechModel = data
        
        self.responseMethod = ({(succeeded: Bool, msg: NSData) -> () in
        })
        
        self.responseMethod = ({(succeeded: Bool, msg: NSData) -> () in
            
            if(succeeded)
            {
                dispatch_async(dispatch_get_main_queue(), {
                    let json = JSONObject(data: msg)
                    ResponseJSONManager().delegate(json,data: &self.sechModel)
                    finishMethod(msg: "DONE",data: self.sechModel)
                    })
            }else {
                finishMethod(msg: "ERROR",data: self.sechModel)
            }
        })
        

    }

    func delegate(isDetailRequest detail: Bool){
        if detail {

        }else{
            makeRequest(QueryJSONManager().createRequestJSON(sechModel.sechs,preferences: [:]),detail: detail)
        }
    }
    
    private func makeRequest(json:JSONObject,detail:Bool)->Bool{
        if detail{
            //ConnectionManager().makeHTTP_Request(json, url: PROJECT_URL.GETDETAILS, httpMethod: ConnectionManager.POST, postCompleted: self.detaileResponseMethod)
        }else{
            ConnectionManager().makeHTTP_Request(json, url: PROJECT_URL.RECOMMEND, httpMethod: ConnectionManager.POST, postCompleted: self.responseMethod)
        }
        
        return  true
    }
    
}
