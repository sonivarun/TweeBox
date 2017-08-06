//
//  ResourceURL.swift
//  TweeBox
//
//  Created by 4faramita on 2017/7/28.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import Foundation

struct ResourceURL {
    static let user_timeline = (url: "https://api.twitter.com/1.1/statuses/user_timeline.json", method: "GET")
    static let home_timeline = (url: "https://api.twitter.com/1.1/statuses/home_timeline.json", method: "GET")
    static let search_tweets = (url: "https://api.twitter.com/1.1/search/tweets.json", method: "GET")
}
