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
    
    let sechs:[String:Sech]
    var responses = [String:[Response]]()
    
    init(sechs:[String:Sech]){
        self.sechs = sechs
    }
}