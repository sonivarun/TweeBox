//
//  Constants.swift
//  TweeBox
//
//  Created by 4faramita on 2017/7/28.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let tweetLimitPerRefresh = "50"
    static let picQuality = MediaSize.large
    
    static let aspectRatioWidth: CGFloat = 16
    static let aspectRatioHeight: CGFloat = 9
    
    static let normalAspect = aspectRatioHeight / aspectRatioWidth
    static let thinAspect = normalAspect * 2
    
    static let picCornerRadius: CGFloat = 5
}
