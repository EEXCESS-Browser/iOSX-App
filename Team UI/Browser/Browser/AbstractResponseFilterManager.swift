//
//  AbstractResponseFilterManager.swift
//  Browser
//
//  Created by Alexander Pöhlmann on 05.12.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import Foundation

protocol AbstractResponse{
    func delegate(data:NSData,inout storage:SechPage);
}

class AbstractResponseFilterManager:AbstractResponse{
    
    func delegate(data:NSData,inout storage:SechPage){
        
    }
}