//
//  Rules.swift
//  Browser
//
//  Created by Lothar Manuel Mödl on 23.11.15.
//  Copyright © 2015 SECH-Tag-EEXCESS-Browser. All rights reserved.
//

import Foundation

protocol Rule{
    var weighting: Double {get}
}




struct MediaType: Rule {
    var weighting: Double = 0.5
    
    func isUsersMediaType(userMediaType: String, recommendationMediaType: String)->RuleMatch{
        
        return (recommendationMediaType == userMediaType ? RuleMatch.Match : RuleMatch.NoMatch)
    }
}

enum RuleMatch{
    case Match, NoMatch
    
    func simpleDescription()->Int{
        switch self{
        case .Match:
            return 1
        case .NoMatch:
            return 0
        
        }
        
    }
}