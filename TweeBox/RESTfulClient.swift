//
//  RESTfulClient.swift
//  TweeBox
//
//  Created by 4faramita on 2017/7/28.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import Foundation
import TwitterKit

class RESTfulClient {
    
    private var resource: (url: String, method: String)
    
    private var params: [String: String]?
    
//    private var dataJSON: Data?
    
    init(resource: (url: String, method: String), params: [String: String]?) {
        self.resource = resource
        self.params = params
    }
    
    public func getData(_ handler: @escaping (_ data: Data) -> Void) {
        
        
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {

            let client = TWTRAPIClient(userID: userID)
            var clientError : NSError?
            
            let request = client.urlRequest(withMethod: resource.method, url: resource.url, parameters: params, error: &clientError)
            
            client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                if connectionError != nil {
                    print("Error: \(connectionError!)")
                }
                
                if data != nil {
                    handler(data!)
                }
            }
        }
    }
}
