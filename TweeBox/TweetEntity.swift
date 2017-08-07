//
//  TweetEntity.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/7.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import Foundation
import SwiftyJSON

class TweetEntity {
    
    var indices: [Int]
    
    init(with json: JSON) {
        indices = json["indices"].arrayValue.map({ $0.intValue })
    }
}
