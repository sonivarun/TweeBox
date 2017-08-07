//
//  TweetPhotoSize.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/7.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import Foundation
import SwiftyJSON

struct TweetPhotoSize {
    
    public var thumb: sizeObject
    public var small: sizeObject
    public var medium: sizeObject
    public var large: sizeObject
    
    init(with json: JSON) {
        thumb = sizeObject(with: json["thumb"])
        small = sizeObject(with: json["small"])
        medium = sizeObject(with: json["medium"])
        large = sizeObject(with: json["large"])
    }
    
    struct sizeObject {
        
        public var w: Int
        public var h: Int
        public var resize: String
        
        init(with json: JSON) {
            w = json["w"].intValue
            h = json["h"].intValue
            resize = json["resize"].stringValue
        }
    }
}
