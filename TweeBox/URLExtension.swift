//
//  URLExtension.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/8.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import Foundation

extension URL {
    
    init?(string: String, quality: MediaSize) {
        
        var typedString = string
        if string != "" {
            switch quality {
            case .thumb:
                typedString += MediaSize.thumb.rawValue
            case .small:
                typedString += MediaSize.small.rawValue
            case .medium:
                typedString += MediaSize.medium.rawValue
            case .large:
                typedString += MediaSize.large.rawValue
            }
        }
        self.init(string: typedString)
        print(self.absoluteString)
    }
}
