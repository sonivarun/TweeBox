//
//  FollowerTableViewController.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/15.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit

class FollowerTableViewController: UserListTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        resourceURL = ResourceURL.followers_list
    }
    
    init(followerListParams: UserListParams) {
        self.userListParams = followerListParams
    }
}
