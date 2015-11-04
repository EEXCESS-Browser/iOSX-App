//
//  Regex.swift
//  Browser
//
//  Created by Brian Mairhörmann on 04.11.15.
//  Copyright © 2015 drui. All rights reserved.
//

import Foundation

class Regex {
    
    func findSechTagsInBody(inString string : String) -> [String]{
        
        let pattern = "<sech([a-z0-9]*)\\b[^>]*>"
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
        let range = NSMakeRange(0, string.characters.count)
        let matches = regex.matchesInString(string, options: NSMatchingOptions(), range: range)
        
        return matches.map {
            let range = $0.range
            return (string as NSString).substringWithRange(range)
        }
    }
    
    func isSechSection(inString string : String) -> Bool {
        
        let pattern = "<sech-section"
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
        let range = NSMakeRange(0, string.characters.count)
        return regex.firstMatchInString(string, options: NSMatchingOptions(), range: range) != nil
    }
    
    func isSechLink(inString string : String) -> Bool {
        
        let pattern = "<sech-link"
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
        let range = NSMakeRange(0, string.characters.count)
        return regex.firstMatchInString(string, options: NSMatchingOptions(), range: range) != nil
    }
    
}