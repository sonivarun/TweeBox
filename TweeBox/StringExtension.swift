//
//  StringExtension.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/16.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import Foundation

extension String {
    
    func startsWith(string: String) -> Bool {
        
        guard let range = rangeOfString(string, options:[.AnchoredSearch, .CaseInsensitiveSearch]) else {
            return false
        }
        
        return range.startIndex == startIndex
    }
    
}
