//
//  TimelineParams.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/9.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import Foundation

class TimelineParams {
    
    public var sinceID: String?
    
    //    count: no need to define here
    
    public var maxID: String?
    
    //    trimUser
    
    public var excludeReplies = false
    
    public var includeRetweets = true
    
    public var resourceURL: (String, String)!
    

    init(sinceID: String? = nil, maxID: String? = nil, excludeReplies: Bool?, includeRetweets: Bool?) {
        
        self.sinceID = sinceID
        self.maxID = maxID
        if let excludeReplies = excludeReplies {
            self.excludeReplies = excludeReplies
        }
        if let includeRetweets = includeRetweets {
            self.includeRetweets = includeRetweets
        }
    }
    
    public func getParams() -> [String: String] {
        
        var params = [String: String]()
        
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
