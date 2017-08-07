//
//  TwitterUser.swift
//  TweeBox
//
//  Created by 4faramita on 2017/7/28.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import Foundation
import SwiftyJSON

struct TwitterUser {
    
    public var id: String
    
    public var location: String?
    
    public var name: String  // not the @ one, that's the "screen_name"
    public var screenName: String
    
    public var url: String?
    // A URL provided by the user in association with their profile.
    
    public var createdAt: String
    
    public var defaultProfile: Bool
    // When true, indicates that the user has not altered the theme or background of their user profile.
    public var defaultProfileImage: Bool
    
    public var description: String?
    public var entities: Entity
    // Entities which have been parsed out of the url or description fields defined by the user.
    
    public var verified: Bool
    
    public var favouritesCount: Int
    
    public var followRequestSent: Bool?
    // When true, indicates that the authenticating user has issued a follow request to this protected user account
    public var following: Bool?
    public var followersCount: Int
    public var followingCount: Int  // friends_count
    
    public var geoEnabled: Bool
    // When true, indicates that the user has enabled the possibility of geotagging their Tweets. 
    // This field must be true for the current user to attach geographic data when using POST statuses / update .
    
    public var isTranslator: Bool
    // When true, indicates that the user is a participant in Twitter’s translator community .
    
    public var lang: String
    
    public var listedCount: Int
    // The number of public lists that this user is a member of.
    
    public var notifications: Bool?
    // Indicates whether the authenticated user has chosen to receive this user’s Tweets by SMS.
    
    public var profileBackgroundColor: String
    // The hexadecimal color chosen by the user for their background.
    
    public var profileBackgroundImageURLHTTP: String  // profile_background_image_url
    public var profileBackgroundImageURL: String  // profile_background_image_url_https
    public var profileBackgroundTile: Bool
    // When true, indicates that the user’s profile_background_image_url should be tiled when displayed.
    public var profileBannerURL: String
    // By adding a final path element of the URL, 
    // it is possible to obtain different image sizes optimized for specific displays.
    public var profileImageURLHTTP: String  // profile_image_url
    public var profileImageURL: String  // profile_image_url_https
    public var profileUseBackgroundImage: Bool
    
//    public var profile_link_color: String
//    public var profile_sidebar_border_color: String
//    public var profile_sidebar_fill_color: String
//    public var profile_text_color: String
    
    public var protected: Bool
    
    public var status: Tweet?
    public var statusesCount: Int
    // The number of Tweets (including retweets) issued by the user.
    
    public var timeZone: String?
    public var utcOffset: Int?
    // The offset from GMT/UTC in seconds.

//    public var withheld_in_countries: String?
//    public var withheld_scope: String?
    
    init(with userJSON: JSON) {
        id                            = userJSON["id_str"].stringValue
        location                      = userJSON["location"].string
        name                          = userJSON["name"].stringValue
        screenName                    = userJSON["screen_name"].stringValue
        url                           = userJSON["url"].string
        createdAt                     = userJSON["created_at"].stringValue
        defaultProfile                = userJSON["default_profile"].bool ?? true
        defaultProfileImage           = userJSON["default_profile_image"].bool ?? true
        description                   = userJSON["description"].string
        entities                      = Entity(with: userJSON["entities"], and: JSON.null)  // ((userJSON["entities"].null == nil) ? (Entity(with: userJSON["entities"])) : nil)
        verified                      = userJSON["verified"].bool ?? false
        favouritesCount               = userJSON["favourites_count"].int ?? 0
        followRequestSent             = userJSON["follow_request_sent"].bool
        following                     = userJSON["following"].bool
        followersCount                = userJSON["followers_count"].int ?? 0
        followingCount                = userJSON["friends_count"].int ?? 0
        geoEnabled                    = userJSON["geo_enabled"].bool ?? false
        isTranslator                  = userJSON["is_translator"].bool ?? false
        lang                          = userJSON["lang"].stringValue
        listedCount                   = userJSON["listed_count"].int ?? 0
        notifications                 = userJSON["notifications"].bool
        profileBackgroundColor        = userJSON["profile_background_color"].stringValue
        profileBackgroundImageURLHTTP = userJSON["profile_background_image_url"].stringValue
        profileBackgroundImageURL     = userJSON["profile_background_image_url_https"].stringValue
        profileBackgroundTile         = userJSON["profile_background_tile"].bool ?? false
        profileBannerURL              = userJSON["profile_banner_url"].stringValue
        profileImageURLHTTP           = userJSON["profile_image_url"].stringValue
        profileImageURL               = userJSON["profile_image_url_https"].stringValue
        profileUseBackgroundImage     = userJSON["profile_use_background_image"].bool ?? true
        protected                     = userJSON["protected"].bool ?? false
        status                        = ((userJSON["status"].null == nil) ? (Tweet(with: userJSON["status"])) : nil)
        statusesCount                 = userJSON["statuses_count"].int ?? 0
        timeZone                      = userJSON["time_zone"].string
        utcOffset                     = userJSON["utc_offset"].int
    }
}
