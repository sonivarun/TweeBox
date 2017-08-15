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
    static let tweetLimitPerRefresh = "10"
    static let picQuality = MediaSize.large
    
    static let aspectRatioWidth: CGFloat = 16
    static let aspectRatioHeight: CGFloat = 9
    
    static let normalAspect = aspectRatioHeight / aspectRatioWidth
    static let thinAspect = normalAspect * 2
    
    static let picCornerRadius: CGFloat = 3

    static let defaultProfileRadius = ProfileRadius.round.rawValue
    
    static let picFadeInDuration = 0.2
    
    static let naturalReading = true
    
    static let profileImageRadius: CGFloat = 50
    static let profilePanelHeight: CGFloat = 250
    static let profilePanelDragOffset: CGFloat = 100
    static let profileToolbarHeight: CGFloat = 50
}

enum ProfileRadius: CGFloat {
    case round = 200
    case square = 20
}
