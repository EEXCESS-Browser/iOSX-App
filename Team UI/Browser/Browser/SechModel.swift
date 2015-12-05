//
//  SechModel.swift
//  Browser
//
//  Created by Brian Mairhörmann on 21.10.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import Foundation

class SechModel{
    var sechpages:[String:SechPage]
    
    init(){
        self.sechpages = [String:SechPage]()
    }
}


class SechPage{
    static let instance = SechPage()
    var sechs:[String:Sech]
    
    init(){
        sechs = [String:Sech]()
    }
}