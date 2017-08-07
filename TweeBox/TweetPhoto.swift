//
//  TweetPhoto.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/7.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import Foundation
import SwiftyJSON

class TweetPhoto: TweetEntity {
    
    public var id: String
    
    public var media_url: String
    public var media_url_https: String
    public var url: String
    // The media URL that was extracted
    public var display_url: String
    // Not a URL but a string to display instead of the media URL
    public var expanded_url: String
    // The fully resolved media URL
    
    public var sizes: TweetMediaSize
    /*
     We support different sizes: thumb, small, medium and large. 
     The media_url defaults to medium but you can retrieve the media in different sizes by appending a colon + the size key 
     (for example: http://pbs.twimg.com/media/A7EiDWcCYAAZT1D.jpg:thumb ). 
     Each available size comes with three attributes that describe it: 
     w : the width (in pixels) of the media in this particular size; 
     h : the height (in pixels) of the media in this particular size; 
     and resize : how we resized the media to this particular size (can be crop or fit )
     */
    
    public var type: String
    
    public var ext_alt_text: String?
    
    public var source_status_id: String?
    // For Tweets containing media that was originally associated with a different tweet, 
    // this string-based ID points to the original Tweet.
    
    
    // for video
    
    public var video_info: String?
    // Contains information about aspect ratio. 
    // Typical values are [4, 3] or [16, 9]. 
    // This field is present only when there is a video in the payload.
    
    public var duration_millis: Int?
    
    public var variants:
    
}
