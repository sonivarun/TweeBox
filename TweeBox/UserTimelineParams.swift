//
//  UserTimelineParams.swift
//  TweeBox
//
//  Created by 4faramita on 2017/7/31.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import Foundation

class UserTimelineParams: TimelineParams {
        
    public var userID: String?
    
//    screenName

    init(of userID: String, sinceID: String? = nil, maxID: String? = nil, excludeReplies: Bool = false, includeRetweets: Bool = true) {
        
        self.userID = userID
        
        super.init(excludeReplies: nil, includeRetweets: nil)
        resourceURL = ResourceURL.user_timeline
    }
    
    override public func getParams() -> [String: String] {
        var params = super.getParams()
        
        if userID != nil {
            params["user_id"] = userID
        }
        
        return params
    }
}
