//
//  SechManager.swift
//  Browser
//
//  Created by Burak Erol on 10.12.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import Foundation

class SechManager {
    private let regex = RegexForSech()
    private let headFilter = Filter()
    private var sechCollection = [SEACHModel]()
    
    // TODO: Validation of Filterattributes
    private var validationFilterMediaType = []
    
    func getSechObjects(htmlHead : String, htmlBody : String) -> [SEACHModel] {
        
        let sechHead = getSechHead(htmlHead)
        makeSech(sechHead, htmlBody: htmlBody)
        
        let tmpSechCollection = sechCollection
        sechCollection = [SEACHModel]()
        
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
    
    private func makeSech(head: Tag, htmlBody : String){
        
        let sechBodyArray = regex.findSechTags(inString: htmlBody)
        var tmpSection = Tag()
        var tmpFilter = headFilter
        var sectionIsAvailable = false
        
        for (var i = 0; i < sechBodyArray.count-1; i++){
            
            //Check for Closingtags
            if regex.isSechSectionClosing(inString: sechBodyArray[i]){
                tmpFilter = headFilter
                sectionIsAvailable = false
                continue
            }
            if regex.isSechLinkClosing(inString: sechBodyArray[i]){
                continue
            }
            
            //Check if Element is Section
            if regex.isSechSection(inString: sechBodyArray[i]){
                tmpSection = makeTagObject(sechBodyArray[i], isMainTopic: false)
                tmpFilter = setFilter(tmpFilter, newFilter: sechBodyArray[i])
                sectionIsAvailable = true
                continue
            }
            
            // Check if Element is Link
            if regex.isSechLink(inString: sechBodyArray[i]){
                if sectionIsAvailable == true{
                    tmpFilter = setFilter(tmpFilter, newFilter: sechBodyArray[i])
                    let link = makeTagObject(sechBodyArray[i], isMainTopic: true)
                    makeSechObject(head, section: tmpSection, link: link, filter: tmpFilter)
                }
                if sectionIsAvailable == false{
                    tmpFilter = setFilter(headFilter, newFilter: sechBodyArray[i])
                    let link = makeTagObject(sechBodyArray[i], isMainTopic: true)
                    makeSechObject(head, section: Tag(), link: link, filter: tmpFilter)
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
        let sechObject = SEACHModel()
        
        sechObject.tags = ["head" : head, "section" : section, "link" : link]
        sechObject.filters = filter
        sechObject.id = (sechObject.tags["link"]?.topic)!
        
        sechCollection.append(sechObject)
    }
}
