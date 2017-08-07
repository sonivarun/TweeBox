//
//  Coordinates.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/5.
//  Copyright © 2017年 4faramita. All rights reserved.
//

//  The inner coordinates array is formatted as geoJSON (longitude first, then latitude)

import Foundation
import SwiftyJSON

struct Coordinates {
    
    public var type: String
    
    public var coordinates: [Any]
    
    init(with json: JSON) {
        
        type = json["type"].string ?? "Point"
        
        switch type {
        case "Point":
            coordinates = json["coordinates"].arrayValue.map({ $0.floatValue })
        case "Polygon":
            coordinates = [json["coordinates"][0].arrayValue.map({ [$0[0].floatValue, $0[1].floatValue] })]
        default:
            coordinates = [0.0, 0.0]
        }
    }
}
