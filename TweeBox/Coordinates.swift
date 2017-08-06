//
//  Coordinates.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/5.
//  Copyright © 2017年 4faramita. All rights reserved.
//

//  The inner coordinates array is formatted as geoJSON (longitude first, then latitude)

import Foundation

struct Coordinates {
    
    public var coordinates: (Float, Float)
    
    public var type: String = "Point"
}
