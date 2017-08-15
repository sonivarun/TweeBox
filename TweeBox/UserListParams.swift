//
//  UserListParams.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/15.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import Foundation
struct UserListParams {
    
    public var userID: String
    public var cursor: String? = "-1"
    public var count = Constants.userLimitPerRefresh
    public var skipStatus = true
    public var includeUserEntities = false
    
    init(userID: String) {
        self.userID = userID
    }
    
    public func getParams() -> [String: String] {
        
        var params = [String: String]()
        
        params["user_id"] = userID
        
        params["cursor"] = cursor
        
        params["count"] = count
        
        params["skip_status"] = skipStatus ? "true" : "false"
        
        params["include_user_entities"] = includeUserEntities ? "true" : "false"
        
        return params
    }

}
