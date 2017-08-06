//
//  Tweet.swift
//  TweeBox
//
//  Created by 4faramita on 2017/7/28.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import Foundation

class Tweet {
    
    public var coordinates: Coordinates?
    
    public var createdTime: String?
    
    public var currenUserRetweet: String?
    // Only surfaces on methods supporting the include_my_retweet parameter, when set to true.
    // Details the Tweet ID of the user’s own retweet (if existent) of this Tweet.
    
    public var entities: Entities?
    
    public var favoriteCount: Int? = 0
    
    public var favorited: Bool
    
    public var filterLevel: String?
    // Indicates the maximum value of the filter_level parameter which may be used and still stream this Tweet. 
    // So a value of medium will be streamed on none, low, and medium streams.
    
    public var id: String = ""
    
    
    public var inReplyToScreenName: String?
    
    public var inReplyToStatusID: String?
    // If the represented Tweet is a reply, this field will contain the integer representation of the original Tweet’s ID.
    
    public var inReplyToUserID: String?
    // If the represented Tweet is a reply, this field will contain the string representation of the original Tweet’s author ID. 
    // This will not necessarily always be the user directly mentioned in the Tweet.
    
    
    public var lang: String?
    
    public var place: Places?
    
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
    
    public var source: String = ""
    // Utility used to post the Tweet, as an HTML-formatted string. 
    // Tweets from the Twitter website have a source value of web.
    
    public var text: String = ""
    
    public var truncated: Bool
    /*
     Indicates whether the value of the text parameter was truncated, for example, as a result of a retweet exceeding the 140 character Tweet length. 
     Truncated text will end in ellipsis, like this ... Since Twitter now rejects long Tweets vs truncating them, the large majority of Tweets will have this set to false. 
     Note that while native retweets may have their toplevel text property shortened, the original text will be available under the retweeted_status object and the truncated parameter will be set to the value of the original status (in most cases, false).
     */
    
    public var user: TwitterUsers
    
    public var withheldCopyright: Bool?
    // When present and set to “true”, it indicates that this piece of content has been withheld due to a DMCA complaint.

    public var withheldInCountries: [String]?
    // When present, indicates a list of uppercase two-letter country codes this content is withheld from. Twitter supports the following non-country values for this field:
    //  “XX” - Content is withheld in all countries “XY” - Content is withheld due to a DMCA request.
    
    public var withheldScope: String?
    // When present, indicates whether the content being withheld is the “status” or a “user.”
    
    init(
        coordinates: Coordinates?,
        createdTime: String,
        currenUserRetweet: String?,
        entities: Entities,
        favoriteCount: Int?,
        favorited: Bool,
        filterLevel: String?,
        id: String,
        inReplyToScreenName: String?,
        inReplyToStatusID: String?,
        inReplyToUserID: String?,
        lang: String?,
        place: Places?,
        possiblySensitive: Bool?,
        quotedStatusID: String?,
        quotedStatus: Tweet?,
        retweetCount: Int = 0,
        retweeted: Bool,
        retweetedStatus: Tweet?,
        source: String,
        text: String,
        truncated: Bool = false,
        user: TwitterUsers,
        withheldCopyright: Bool?,
        withheldInCountries: [String]?,
        withheldScope: String?
    ) {
        self.id = id
        
        if coordinates != nil { self.coordinates = coordinates }
        
        self.source = source
        
        self.text = text
        self.truncated = truncated
        
        self.user = user
        
        self.createdTime = createdTime
        
        self.entities = entities
        
        if favoriteCount != nil { self.favoriteCount = favoriteCount }
        self.favorited = favorited
        
        if filterLevel != nil { self.filterLevel = filterLevel }
        
        if inReplyToScreenName != nil { self.inReplyToScreenName = inReplyToScreenName }
        if inReplyToStatusID != nil { self.inReplyToStatusID = inReplyToStatusID }
        if inReplyToUserID != nil { self.inReplyToUserID = inReplyToUserID }
        
        if lang != nil { self.lang = lang }
        
        if place != nil { self.place = place }
        
        if possiblySensitive != nil { self.possiblySensitive = possiblySensitive }
        
        if quotedStatusID != nil { self.quotedStatusID = quotedStatusID }
        if quotedStatus != nil { self.quotedStatus = quotedStatus }
        if quotedStatus != nil { self.quotedStatus = quotedStatus }
        
        self.retweetCount = retweetCount
        self.retweeted = retweeted
        if retweetedStatus != nil { self.retweetedStatus = retweetedStatus }
        if currenUserRetweet != nil { self.currenUserRetweet = currenUserRetweet }
        
        if withheldCopyright != nil { self.withheldCopyright = withheldCopyright }
        if withheldInCountries != nil { self.withheldInCountries = withheldInCountries }
        if withheldScope != nil { self.withheldScope = withheldScope }
    }
}
