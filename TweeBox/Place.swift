//
//  Place.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/5.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Place {
    
    public var attributes: PlaceAttributes
    public var boundingBox: Coordinates
    public var country: String
    public var countryCode: String
    public var fullName: String
    public var id: String
    public var name: String
    public var placeType: String
    public var url: String
    
    init(with json: JSON) {
        
        attributes  = PlaceAttributes(with: json["attributes"])
        boundingBox = Coordinates(with: json["bounding_box"])
        country     = json["country"].string ?? ""
        countryCode = json["country_code"].string ?? ""
        fullName    = json["full_name"].string ?? ""
        id          = json["id"].string ?? ""
        name        = json["name"].string ?? ""
        placeType   = json["place_type"].string ?? ""
        url         = json["url"].string ?? ""
    }
    
    
    struct PlaceAttributes {
        
        public var streetAddress: String?
        public var locality: String?
        // the city the place is in
        public var region: String?
        // the administrative region the place is in
        public var iso3: String?
        // the country code
        public var postalCode: String?
        // in the preferred local format for the place
        public var phone: String?
        // in the preferred local format for the place, include long distance code
        public var twitter: String?
        // twitter screen-name, without @
        public var url: String?
        // official/canonical URL for place
//        public var appID: String?
        // An ID or comma separated list of IDs representing the place in the applications place database.
        
        init(with json: JSON) {
            
            streetAddress = json["street_address"].string
            locality = json["locality"].string
            region = json["region"].string
            iso3 = json["iso3"].string
            postalCode = json["postal_code"].string
            phone = json["phone"].string
            twitter = json["twitter"].string
            url = json["url"].string
//            appID = json["app:id"].string
        }
    }
}
