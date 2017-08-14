//
//  HomeTimelineParams.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/9.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import Foundation

class HomeTimelineParams: TimelineParams {
    
    override init(sinceID: String? = nil, maxID: String? = nil, excludeReplies: Bool? = false, includeRetweets: Bool? = true) {
        
        super.init(excludeReplies: nil, includeRetweets: nil)
        resourceURL = ResourceURL.home_timeline
    }
}
