//
//  AbstractQueryBuildManager.swift
//  Browser
//
//  Created by Alexander Pöhlmann on 05.12.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import Foundation

protocol AbstractQueryBuild{
    func delegate(sechs:[String:Sech],preferences:[String:String])->NSData?
}

class AbstractQueryBuildManager:AbstractQueryBuild{
    
    func delegate(sechs:[String:Sech],preferences:[String:String])->NSData?{
        return nil
    }
}