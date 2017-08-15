//
//  UserList.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/15.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import Foundation
import TwitterKit
import SwiftyJSON

class UserList {
    
    public var userList = [TwitterUser]()
    public var nextCursor = "0"
    public var previousCursor = "0"
    
    public var fetchOlder = true
    public var resourceURL: (String, String)
    public var userListParams: UserListParams
    
    init(resourceURL: (String, String), userListParams: UserListParams, fetchOlder: Bool?, nextCursor: String?, previousCursor: String?) {
        
        self.resourceURL = resourceURL
        
        self.userListParams = userListParams
        
        if let fetchOlder = fetchOlder {
            self.fetchOlder = fetchOlder
        }
        
        if let nextCursor = nextCursor {
            self.nextCursor = nextCursor
        }
        
        if let previousCursor = previousCursor {
            self.previousCursor = previousCursor
        }
    }
    
    
    public func fetchData(_ handler: @escaping (String, String, [TwitterUser]) -> Void) {
        
        if Twitter.sharedInstance().sessionStore.session()?.userID != nil {
            
            if fetchOlder, previousCursor != "-1" {
                userListParams.cursor = previousCursor
            }
            
            if !fetchOlder, nextCursor != "-1" {
                userListParams.cursor = nextCursor
            }
            
            let client = RESTfulClient(resource: resourceURL, params: userListParams.getParams())
            
            client.getData() { data in
                let json = JSON(data: data)
//                print(json)
                
                self.nextCursor = json["next_cursor_str"].stringValue
                self.previousCursor = json["previous_cursor_str"].stringValue
                
                for (_, userJSON) in json["users"] {
                    if userJSON.null == nil {
                        let user = TwitterUser(with: userJSON)
                        self.userList.append(user)  // mem cycle?
                    }
                }
                
                handler(self.nextCursor, self.previousCursor, self.userList)
            }
        }
    }

}
