//
//  UserTimelineParams.swift
//  TweeBox
//
//  Created by 4faramita on 2017/7/31.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import Foundation

class UserTimelineParams {
    public var userID: String?
    
//    screenName
    
    public var sinceID: String?
    
//    count: no need to define here
    
    public var maxID: String?
    
//    trimUser
    
    public var excludeReplies: Bool
    
//    public var excludeReplies: String {
//        return (_excludeReplies ? "true" : "false")
//    }
    
    public var includeRetweets: Bool
    
//    public var excludeRetweets: String {
//        return (_excludeRetweets ? "true" : "false")
//    }
    
    public var params: [String: String] {
        return getParams()
    }
    
    init(of userID: String, sinceID: String? = nil, maxID: String? = nil, excludeReplies: Bool = false, includeRetweets: Bool = true) {
        
        self.userID = userID
        self.sinceID = sinceID
        self.maxID = maxID
        self.excludeReplies = excludeReplies
        self.includeRetweets = includeRetweets
    }
    
    public func getParams() -> [String: String] {
        var params = [String: String]()
        
        if userID != nil {
            params["user_id"] = userID
        }
        
        if sinceID != nil {
            params["since_id"] = sinceID
        }
        
        params["count"] = Constants.tweetLimitPerRefresh
        
        if maxID != nil {
            params["max_id"] = maxID
        }
        
        if excludeReplies {
            params["exclude_replies"] = "true"
        }
        
        if !includeRetweets {
            params["include_rts"] = "false"
        }
        
        return params
    }
}
