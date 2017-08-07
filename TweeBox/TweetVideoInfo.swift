//
//  TweetVideoInfo.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/7.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import Foundation
import SwiftyJSON

struct TweetVideoInfo {
    
    public var aspectRatio: [Int]
    // Contains information about aspect ratio.
    // Typical values are [4, 3] or [16, 9].
    // This field is present only when there is a video in the payload.
    
    public var duration: Int?
    
    public var variants: [TweetVideoVariant]?
    
    init(with json: JSON) {
        aspectRatio = json["aspect_ratio"].arrayValue.map { $0.intValue }
        duration = json["duration_millis"].int
        variants = json["variants"].arrayValue.map { TweetVideoVariant(with: $0) }
    }
    
    struct TweetVideoVariant {
        
        public var bitrate: String
        public var contentType: String
        public var url: String
        
        init(with json: JSON) {
            bitrate = json["bitrate"].stringValue
            contentType = json["content_type"].stringValue
            url = json["url"].stringValue
            
        }
    }
}
