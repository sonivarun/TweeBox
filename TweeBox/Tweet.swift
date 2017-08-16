//
//  Tweet.swift
//  TweeBox
//
//  Created by 4faramita on 2017/7/28.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import Foundation
import SwiftyJSON

class Tweet {
    
    public var coordinates: Coordinates?
    
    public var createdTime: Date?
    
    public var currenUserRetweet: String?
    // Only surfaces on methods supporting the include_my_retweet parameter, when set to true.
    // Details the Tweet ID of the user’s own retweet (if existent) of this Tweet.
    
    public var entities: Entity?
    
    public var favoriteCount: Int?
    
    public var favorited: Bool
    
    public var filterLevel: String?
    // Indicates the maximum value of the filter_level parameter which may be used and still stream this Tweet.
    // So a value of medium will be streamed on none, low, and medium streams.
    
    public var id: String
    
    
    public var inReplyToScreenName: String?
    
    public var inReplyToStatusID: String?
    // If the represented Tweet is a reply, this field will contain the integer representation of the original Tweet’s ID.
    
    public var inReplyToUserID: String?
    // If the represented Tweet is a reply, this field will contain the string representation of the original Tweet’s author ID.
    // This will not necessarily always be the user directly mentioned in the Tweet.
    
    
    public var lang: String?
    
    public var place: Place?
    
    public var possiblySensitive: Bool?
    
    public var quotedStatusID: String?
    // This field only surfaces when the Tweet is a quote Tweet. This field contains the integer value Tweet ID of the quoted Tweet.
    
    public var quotedStatus: Tweet?
    // This field only surfaces when the Tweet is a quote Tweet.
    // This attribute contains the Tweet object of the original Tweet that was quoted.
    
    //    public var scopes
    
    public var retweetCount: Int
    
    public var retweeted: Bool
    
    public var retweetedStatus: Tweet?
    
    public var source: String
    // Utility used to post the Tweet, as an HTML-formatted string.
    // Tweets from the Twitter website have a source value of web.
    
    public var text: String
    
    public var truncated: Bool
    /*
     Indicates whether the value of the text parameter was truncated, for example, as a result of a retweet exceeding the 140 character Tweet length.
     Truncated text will end in ellipsis, like this ... Since Twitter now rejects long Tweets vs truncating them, the large majority of Tweets will have this set to false.
     Note that while native retweets may have their toplevel text property shortened, the original text will be available under the retweeted_status object and the truncated parameter will be set to the value of the original status (in most cases, false).
     */
    
    public var user: TwitterUser
    
//    public var withheldCopyright: Bool?
    // When present and set to “true”, it indicates that this piece of content has been withheld due to a DMCA complaint.
    
//    public var withheldInCountries: [String]?
    // When present, indicates a list of uppercase two-letter country codes this content is withheld from. Twitter supports the following non-country values for this field:
    //  “XX” - Content is withheld in all countries “XY” - Content is withheld due to a DMCA request.
    
//    public var withheldScope: String?
    // When present, indicates whether the content being withheld is the “status” or a “user.”
    
    init(with tweetJSON: JSON
        ) {
        coordinates         = ((tweetJSON["coordinates"].null == nil) ? (Coordinates(with: tweetJSON["coordinates"])) : nil)
        createdTime         = TwitterDate(string: tweetJSON["created_at"].stringValue).date  // tweetJSON["created_at"].stringValue
        currenUserRetweet   = tweetJSON["current_user_retweet"].string
        entities            = Entity(with: tweetJSON["entities"], and: tweetJSON["extended_entities"])  // ((tweetJSON["entities"].null == nil) ? (Entity(with: tweetJSON["entities"])) : nil)
        favoriteCount       = tweetJSON["favorite_count"].int
        favorited           = tweetJSON["favorited"].bool ?? false
        filterLevel         = tweetJSON["filter_level"].string
        id                  = tweetJSON["id_str"].stringValue
        inReplyToScreenName = tweetJSON["in_reply_to_screen_name"].string
        inReplyToStatusID   = tweetJSON["in_reply_to_status_id_str"].string
        inReplyToUserID     = tweetJSON["in_reply_to_user_id_str"].string
        lang                = tweetJSON["lang"].string
        place               = ((tweetJSON["place"].null == nil) ? (Place(with: tweetJSON["place"])) : nil)
        possiblySensitive   = tweetJSON["possibly_sensitive"].bool
        quotedStatusID      = tweetJSON["quoted_status_id_str"].string
        quotedStatus        = ((tweetJSON["quoted_status"].null == nil) ? (Tweet(with: tweetJSON["quoted_status"])) : nil)
        retweetCount        = tweetJSON["retweet_count"].int ?? 0
        retweeted           = tweetJSON["retweeted"].bool ?? false
        retweetedStatus     = ((tweetJSON["retweeted_status"].null == nil) ? (Tweet(with: tweetJSON["retweeted_status"])) : nil)
        source              = tweetJSON["source"].stringValue
        text                = tweetJSON["text"].stringValue
        truncated           = tweetJSON["truncated"].bool ?? false
        user                = TwitterUser(with: tweetJSON["user"])  // ((tweetJSON["user"].null == nil) ? (TwitterUser(with: tweetJSON["user"])) : nil)
        //        withheldCopyright: tweetJSON["withheld_copyright"].bool
        //        withheldInCountries: nil
        //        withheldScope: tweetJSON["withheld_scope"].string
    }
    
    
}
