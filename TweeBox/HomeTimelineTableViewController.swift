//
//  HomeTimelineTableViewController.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/14.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit
import TwitterKit

class HomeTimelineTableViewController: UserTimelineTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userID = Twitter.sharedInstance().sessionStore.session()?.userID ?? ""
    }
}
