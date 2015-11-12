//
//  SechModel.swift
//  Browser
//
//  Created by Brian Mairhörmann on 21.10.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import Foundation

class Sech{
    let id = String()
    let response = String()
    let detail = String()
    let tags = [String : Tag]()
    let filters = [String : Filter]()
}

class Tag {
    let topic = String()
    let type = String()
    let isMainTopic = false
}

class Filter{
    let mediaType = String()
    let provider = String()
    let licence = String()
}

