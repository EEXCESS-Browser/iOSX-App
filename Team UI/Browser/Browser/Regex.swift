//
//  Regex.swift
//  Browser
//
//  Created by Brian Mairhörmann on 04.11.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import Foundation

class RegexForSech {
    
    func findSechTagsInBody(inString string : String) -> [String]{
        
        let pattern = "<sech([a-z0-9]*)\\b[^>]*>"
        let regex = makeRegEx(withPattern: pattern)
        let range = NSMakeRange(0, string.characters.count)
        let matches = regex.matchesInString(string, options: NSMatchingOptions(), range: range)
        
        return matches.map {
            let range = $0.range
            return (string as NSString).substringWithRange(range)
        }
    }
    
    func isSechSection(inString string : String) -> Bool {
        
        let pattern = "<sech-section"
        let regex = makeRegEx(withPattern: pattern)
        let range = NSMakeRange(0, string.characters.count)
        return regex.firstMatchInString(string, options: NSMatchingOptions(), range: range) != nil
    }
    
    func isSechLink(inString string : String) -> Bool {
        
        let pattern = "<sech-link"
        let regex = makeRegEx(withPattern: pattern)
        let range = NSMakeRange(0, string.characters.count)
        return regex.firstMatchInString(string, options: NSMatchingOptions(), range: range) != nil
    }
    
    func getAttributes(inString string : String) -> [String: String]{
        //TODO: Attribute auslesen und in Dictionary schreiben
        
        // Attributes: topic, type, mediaType, provider, licence
        let attributeNames = ["topic", "type", "mediaType", "provider", "licence"]
        // var attributes = [String: String]
        
        for attributeName in attributeNames {
            let regex = makeRegEx(withPattern: attributeName)
            let range = NSMakeRange(0, string.characters.count)
            if regex.firstMatchInString(string, options: NSMatchingOptions(), range: range) != nil {
                //TODO: finde die Attribute heraus
            }
        }
        
        return [:]
    }
    
// Private Methods
//#################################################################################################
    private func makeRegEx(withPattern pattern : String) -> NSRegularExpression{
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
        return regex
    }
}