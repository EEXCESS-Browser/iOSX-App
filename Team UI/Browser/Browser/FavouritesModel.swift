//
//  FavouritesModel.swift
//  Browser
//
//  Created by Patrick Büttner on 31.10.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import Foundation

class FavouritesModel
{
    var title: String
    var url : String
    
    init(title:String, url:String)
    {
        self.title = title
        self.url = url
    }
    
    init()
    {
        self.title = ""
        self.url = ""
    }
    
    var description : String
    {
        return "Title:\(title) , URL:\(url)"
    }
}