//
//  SechMaker.swift
//  SECH Browser
//
//  Created by Brian Mairhörmann on 17.11.15.
//  Copyright © 2015 Hof University. All rights reserved.
//

import Foundation


class SechMaker {
    private var regex = RegexForSech()
    private var headFilter = Filter()
    private var sechCollection = [String : Sech]()
    
    // TODO: Validation of Filterattributes
    private var validationFilterMediaType = []
    
    func getSechObjects(htmlHead : String, htmlBody : String) -> [String : Sech] {
        
        let sechHead = getSechHead(htmlHead)
        makeSech(sechHead, htmlBody: htmlBody)
        
        let tmpSechCollection = sechCollection
        sechCollection = [String : Sech]()
        
        return tmpSechCollection
    }
    
    // Private Methods
    // #################################################################################################
    private func getSechHead(htmlHead : String) -> Tag{
        
        // Get Head-Sech-Tag
        let headSech = regex.findSechTags(inString: htmlHead)
        var headAttributes = [String : String]()
        let head = Tag()
        
        
        if headSech.isEmpty != true{
            headAttributes = regex.getAttributes(inString: "\(headSech[0])")
            
            // Set Headattributes
            head.topic = headAttributes["topic"]!
            head.type = headAttributes["type"]!
            head.isMainTopic = false
            
            // Set Filterattributes
            headFilter.mediaType = headAttributes["mediaType"]!
            headFilter.provider = headAttributes["provider"]!
            headFilter.licence = headAttributes["licence"]!
        }
        return head
    }
    
    private func makeSech(head : Tag, htmlBody : String){
        
        let sechBodyArray = regex.findSechTags(inString: htmlBody)
        var tmpSection = Tag()
        var tmpFilter = headFilter
        
        for(var i=0;i < sechBodyArray.count;i++){
            
            //Startpoint for i-Iterator, then proceed to find Links
            if regex.isSechSection(inString: sechBodyArray[i]){
                tmpSection = makeTagObject(sechBodyArray[i], isMainTopic: false)
                tmpFilter = setFilter(tmpFilter, newFilter: sechBodyArray[i])
            }
            //The Arrayelement is a Link and has no Section
            if regex.isSechLink(inString: sechBodyArray[i]){
                tmpFilter = setFilter(tmpFilter, newFilter: sechBodyArray[i])
                let link = makeTagObject(sechBodyArray[i], isMainTopic: true)
                makeSechObject(head, section: tmpSection, link: link, filter: tmpFilter)
                tmpFilter = headFilter
                tmpSection = Tag()
            }
            //Section is last Element in Array
            if i == sechBodyArray.count-1{
                tmpFilter = headFilter
                tmpSection = Tag()
                return
            }
            
            for (var j=i+1;j < sechBodyArray.count;j++){
                
                if regex.isSechLink(inString: sechBodyArray[j]){
                    tmpFilter = setFilter(tmpFilter, newFilter: sechBodyArray[j])
                    let link = makeTagObject(sechBodyArray[j], isMainTopic: true)
                    makeSechObject(head, section: tmpSection, link: link, filter: tmpFilter)
                }
                if regex.isSechSection(inString: sechBodyArray[j]){
                    tmpFilter = headFilter
                    tmpSection = Tag()
                    i = j
                    break
                }
            }
            
        }
        
    }
    
    private func makeTagObject(tagText : String, isMainTopic : Bool) -> Tag{
        let attributes = regex.getAttributes(inString: tagText)
        let tmpTag = Tag()
        
        tmpTag.isMainTopic = isMainTopic
        tmpTag.topic = attributes["topic"]!
        tmpTag.type = attributes["type"]!
        
        return tmpTag
    }
    
    private func setFilter(oldFilter : Filter, newFilter : String) -> Filter{
        let attributes = regex.getAttributes(inString: newFilter)
        let tmpFilter = Filter()
        
        tmpFilter.mediaType = attributes["mediaType"]!
        tmpFilter.provider = attributes["provider"]!
        tmpFilter.licence = attributes["licence"]!
        
        if tmpFilter.mediaType.isEmpty{
            tmpFilter.mediaType = oldFilter.mediaType
        }
        if tmpFilter.provider.isEmpty{
            tmpFilter.provider = oldFilter.provider
        }
        if tmpFilter.licence.isEmpty{
            tmpFilter.licence = oldFilter.licence
        }
        
        return tmpFilter
    }
    
    private func makeSechObject(head : Tag, section : Tag, link : Tag, filter : Filter){
        let sechObject = Sech()
        
        sechObject.tags = ["head" : head, "section" : section, "link" : link]
        sechObject.filters = filter
        sechObject.id = (sechObject.tags["link"]?.topic)!
        
        sechCollection[sechObject.id] = sechObject
    }
}
