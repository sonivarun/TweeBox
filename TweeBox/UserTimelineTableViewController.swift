//
//  UserTimelineTableViewController.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/10.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit
import TwitterKit
import AMScrollingNavbar

class UserTimelineTableViewController: TimelineTableViewController {

    public var userID: String? {
        didSet {
            print(">>> myself? >> \(userID, Twitter.sharedInstance().sessionStore.session()?.userID, userID == Twitter.sharedInstance().sessionStore.session()?.userID)")
            refreshTimeline()
        }
    }
        
    override func refreshTimeline() {
        
        let userTimelineParams = UserTimelineParams(of: userID!)
        
        let timeline = Timeline(
            maxID: maxID,
            sinceID: sinceID,
            fetchNewer: fetchNewer,
            resourceURL: userTimelineParams.resourceURL,
            timelineParams: userTimelineParams
        )
        
        timeline.fetchData { [weak self] (maxID, sinceID, tweets) in
            if maxID != nil {
                self?.maxID = maxID!
            }
            if sinceID != nil {
                self?.sinceID = sinceID!
            }
            if tweets != nil {
                self?.insertNewTweets(with: tweets!)
//                self?.tableView.reloadData()
            }
            
            Timer.scheduledTimer(
                withTimeInterval: TimeInterval(0.1),
                repeats: false) { (timer) in
                    self?.refreshControl?.endRefreshing()
            }
        }
    }

}
