//
//  TwitterDate.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/16.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import Foundation

struct TwitterDate {
    
    public var string: String?
    
    public let twitterDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    public var date: Date? {
        return twitterDateFormatter.date(from: string ?? "")
    }
}
