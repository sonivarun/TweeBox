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
    
    public var firstPic: TweetMedia? {
        didSet {
            print("first: \(firstPic)")
        }
    }
    public var media: [TweetMedia]?
    
    class Hashtag: TweetEntity {
        
        var text: String
        
        override init(with json: JSON) {
            
            text = json["text"].stringValue
            
            super.init(with: json)
        }
    }
    
    class TweetSymbol: Hashtag { }
    
    class TweetURL: TweetEntity {
        
        var url: URL?
        // The t.co URL that was extracted from the Tweet text
        var displayURL: URL?
        var expandedURL: URL?
        // The resolved URL
        
        override init(with json: JSON) {
            
            url = URL(string: json["url"].stringValue)
            displayURL = URL(string: json["display_url"].stringValue)
            expandedURL = URL(string: json["expanded_url"].stringValue)
            
            super.init(with: json)
        }
    }
    
    class Mention: TweetEntity {
        var id: String
        var screenName: String
        var name: String
        
        override init(with json: JSON) {
            
            id = json["id_str"].stringValue
            screenName = json["screen_name"].stringValue
            name = json["name"].stringValue
            
            super.init(with: json)
        }
    }
    
    init(with json: JSON, and extendedJson: JSON) {
        
        hashtags     = json["hashtags"].arrayValue.map { Hashtag(with: $0) }
        urls         = json["urls"].arrayValue.map { TweetURL(with: $0) }
        userMentions = json["user_mentions"].arrayValue.map { Mention(with: $0) }
        symbols      = json["symbols"].arrayValue.map { TweetSymbol(with: $0) }
                
        if extendedJson.null == nil {
            // there exists extended_json
            firstPic     = TweetMedia(with: extendedJson["media"][0], quality: MediaSize.thumb)
            media = extendedJson["media"].arrayValue.map { TweetMedia(with: $0, quality: Constants.picQuality) }  // media in extended_entities
        }
    }
}
