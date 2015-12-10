//
//  EexcessModel.swift
//  Browser
//
//  Created by Burak Erol on 10.12.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import Foundation

class EEXCESSSingleResponse : CustomStringConvertible {
    var title : String
    var provider : String
    var uri : String?
    
    var description: String {
        get {
            return "Title:\(title) -- Provider:\(provider) -- URI:\(uri)"
        }
    }
    init(title : String, provider : String, uri : String)
    {
        self.title = title
        self.provider = provider
        self.uri = uri
    }
    
    
}
