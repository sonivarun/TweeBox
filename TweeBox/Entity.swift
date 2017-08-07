//
//  Entity.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/5.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Entity {
    
    public var hashtags: [Hashtag]
    public var urls: [TweetURL]
    public var userMentions: [Mention]
    public var symbols: [TweetSymbol]
    public var media: [TweetMedia]
    
    class TweetEntity {
        
        var indices: [Int]
        
        init(with json: JSON) {
            indices = json["indices"].arrayValue.map({ $0.intValue })
        }
    }
    
    class Hashtag: TweetEntity {
        
        var text: String
        
        override init(with json: JSON) {
            
            text = json["text"].string ?? ""
            
            super.init(with: json)
        }
    }
    
    class TweetSymbol: Hashtag { }
    
    class TweetURL: TweetEntity {
        
        var url: String
        // The t.co URL that was extracted from the Tweet text
        var displayUrl: String
        var expandedUrl: String
        // The resolved URL
        
        override init(with json: JSON) {
            
            url = json["url"].string ?? ""
            displayUrl = json["display_url"].string ?? ""
            expandedUrl = json["expanded_url"].string ?? ""
            
            super.init(with: json)
        }
    }
    
    class Mention: TweetEntity {
        var id: String
        var screenName: String
        var name: String
        
        override init(with json: JSON) {
            
            id = json["id_str"].string ?? ""
            screenName = json["screen_name"].string ?? ""
            name = json["name"].string ?? ""
            
            super.init(with: json)
        }
    }
    
    init(with json: JSON, and extendedJson: JSON?) {
        
        hashtags     = json["hashtags"].arrayValue.map { Hashtag(with: $0) }
        urls         = json["urls"].arrayValue.map { TweetURL(with: $0) }
        userMentions = json["user_mentions"].arrayValue.map { Mention(with: $0) }
        symbols      = json["symbols"].arrayValue.map { TweetSymbol(with: $0) }
        
        media = [TweetMedia()]
        
        if let extended = extendedJson, extended.null == nil {
            // there exists extended_json
        }
    }
}
