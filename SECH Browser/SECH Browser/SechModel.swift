//
//  SechModel.swift
//  SECH Browser
//
//  Created by Brian Mairhörmann on 17.11.15.
//  Copyright © 2015 Hof University. All rights reserved.
//

import Foundation

class Sech{
    var id = String()
    var response = String() // TODO: Tbd
    var detail = String() // TODO: Tbd
    var tags = [String : Tag]() // String is id (link, section, head) and Tag is Tag-Object
    var filters = Filter()
}

class Tag {
    var topic = String()
    var type = String()
    var isMainTopic = false
}

class Filter{
    var mediaType = String()
    var provider = String()
    var licence = String()
}