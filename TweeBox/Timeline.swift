//
//  Timeline.swift
//  TweeBox
//
//  Created by 4faramita on 2017/7/28.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import Foundation
import TwitterKit
import SwiftyJSON

class Timeline {
    public var timeline = [Tweet]() {
        didSet {
            print(timeline.count)
        }
    }
    public var maxID: String?
    public var sinceID: String?
    public var fetchNewer = true
    
    init(maxID: String?, sinceID: String?, fetchNewer: Bool) {
        self.maxID = maxID
        self.sinceID = sinceID
        self.fetchNewer = fetchNewer
    }
    
    public func fetchData(_ handler: @escaping (String?, String?, [Tweet]?) -> Void) {
        
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            
            let userTimelineParams = UserTimelineParams(of: userID)
            
            if fetchNewer, sinceID != nil {
                userTimelineParams.sinceID = String(Int(sinceID!)! + 1)
            }
            
            if !fetchNewer, maxID != nil {
                userTimelineParams.maxID = String(Int(maxID!)! - 1)
            }
            
            let client = RESTfulClient(resource: ResourceURL.user_timeline, params: userTimelineParams.params)
            
            client.getData() { data in
                let json = JSON(data: data)
                
                for (_, tweetJSON) in json {
                    let tweet = Tweet(
                        coordinates: nil,
                        createdTime: tweetJSON["created_at"].string ?? "",
                        currenUserRetweet: tweetJSON["current_user_retweet"].string,
                        entities: Entities(),
                        favoriteCount: tweetJSON["favorite_count"].int,
                        favorited: tweetJSON["favorited"].bool ?? false,
                        filterLevel: tweetJSON["filter_level"].string,
                        id: tweetJSON["id_str"].string ?? "",
                        inReplyToScreenName: tweetJSON["in_reply_to_screen_name"].string,
                        inReplyToStatusID: tweetJSON["in_reply_to_status_id_str"].string,
                        inReplyToUserID: tweetJSON["in_reply_to_user_id_str"].string,
                        lang: tweetJSON["lang"].string,
                        place: nil,
                        possiblySensitive: tweetJSON["possibly_sensitive"].bool,
                        quotedStatusID: tweetJSON["quoted_status_id_str"].string,
                        quotedStatus: nil,
                        retweetCount: tweetJSON["retweet_count"].int ?? 0,
                        retweeted: tweetJSON["retweeted"].bool ?? false,
                        retweetedStatus: nil,
                        source: tweetJSON["source"].string ?? "",
                        text: tweetJSON["text"].string ?? "",
                        truncated: tweetJSON["truncated"].bool ?? false,
                        user: TwitterUsers(),
                        withheldCopyright: tweetJSON["withheld_copyright"].bool,
                        withheldInCountries: nil,
                        withheldScope: tweetJSON["withheld_scope"].string
                    )
                    self.timeline.append(tweet)  // mem cycle?
                }
                self.maxID = self.timeline.last?.id  // if fetch tweets below this batch, the earliest one in this batch would be the max one for the next batch
                self.sinceID = self.timeline.first?.id  // vice versa
                
                handler(self.maxID, self.sinceID, self.timeline)
            }
        }
    }
}
