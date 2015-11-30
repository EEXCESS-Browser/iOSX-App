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


class Rules {
    var storedRules: [AnyObject]!
    
    init(){
       // storedRules = [MediaType(), Language, Mendeley]
    }
}





struct MediaType: Rule {
    var weighting: Double = 0.5
    
    init(){
        
    }
    
    func isUsersMediaType(userMediaType: String, recommendationMediaType: String)->RuleMatch{
        
        return (recommendationMediaType == userMediaType ? RuleMatch.Match : RuleMatch.NoMatch)
    }
}

struct Language: Rule{
    var weighting: Double = 0.5
    
    func isUserLanguage(userLanguage: String, recommendationLanguage: String)->RuleMatch{
        return (recommendationLanguage == userLanguage ? RuleMatch.Match : RuleMatch.NoMatch)
    }
    
    func isUserLanguageWithUnknownRecommendationLanguage(userLanguage: String, recommendationLanguage: String)->RuleMatch{
        return getLanguage(recommendationLanguage).simpleDescription() == userLanguage ? RuleMatch.Match : RuleMatch.NoMatch
    }
    
    private func getLanguage(recommendationLanguage: String)->LanguageType{
        if(recommendationLanguage.contains("ö") || recommendationLanguage.contains("ä") || recommendationLanguage.contains("ü")){
            return LanguageType.German
        }else if(recommendationLanguage.contains("the")){
         return LanguageType.English
        }else if(recommendationLanguage.contains("é") || recommendationLanguage.contains("è") || recommendationLanguage.contains("â")){
        return LanguageType.French
        }else if(recommendationLanguage.contains("í") || recommendationLanguage.contains("ó")){
            return LanguageType.Spanish
        }
        
        return LanguageType.Unknown
    }
}

struct Mendeley {
    var weighting: Double = 1.0
    
    func isMendeley(provider: String)->RuleMatch{
        return (provider == "Mendeley" || provider == "mendeley") ? RuleMatch.Match : RuleMatch.NoMatch
    }
}

struct Other {
    
    //init later
    var weigting: Double
    
    func isRuleFulfilled(title: String)->RuleMatch{
        return RuleMatch.NoMatch
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

enum LanguageType{
    case German, English, French, Spanish, Unknown
    
    func simpleDescription()->String{
        switch self{
        case .German:
            return "de"
        case .English:
            return "en"
        case .French:
            return "fr"
        case .Spanish:
            return "es"
        case .Unknown:
            return "unknown"
        }
    }
}

extension String{
    func contains(find: String)->Bool{
        return self.rangeOfString(find, options: NSStringCompareOptions.CaseInsensitiveSearch) != nil
        
    }
}