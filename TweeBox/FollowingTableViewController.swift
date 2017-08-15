//
//  FollowingTableViewController.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/15.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit

class FollowingTableViewController: UserListTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resourceURL = ResourceURL.followings_list
    }
    
    init(followingListParams: UserListParams) {
        self.userListParams = followingListParams
    }
}
