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

    private var sechPage:SechPage

    init(finishMethod:((msg:String,data:SechPage) -> ()),data:SechPage){
        
        self.finishMethod = finishMethod
        self.sechPage = data
        
        self.responseMethod = ({(succeeded: Bool, msg: NSData) -> () in
        })
        
        self.responseMethod = ({(succeeded: Bool, msg: NSData) -> () in
            
            if(succeeded)
            {
                dispatch_async(dispatch_get_main_queue(), {
                    EEXCESSResponseFilterManager().delegate(msg,storage: &self.sechPage)
                    finishMethod(msg: "DONE",data: self.sechPage)
                    })
            }else {
                finishMethod(msg: "ERROR",data: self.sechPage)
            }
        })
        

    }

    func delegate(isDetailRequest detail: Bool){
        if detail {

        }else{
            makeRequest(EEXCESSQueryBuildManager().delegate(sechPage.sechs,preferences: [:])!,detail: detail)
        }
    }
    
    private func makeRequest(data:NSData,detail:Bool)->Bool{
        if detail{
            //ConnectionManager().makeHTTP_Request(json, url: PROJECT_URL.GETDETAILS, httpMethod: ConnectionManager.POST, postCompleted: self.detaileResponseMethod)
        }else{
            ConnectionManager(url: PROJECT_URL.RECOMMEND,postCompleted: self.responseMethod,httpMethod: ConnectionManager.POST).delegate(data)
        }
        
        return  true
    }
    
}
