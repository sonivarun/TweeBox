//
//  TimelineTableViewController.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/6.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit
import TwitterKit

class TimelineTableViewController: UITableViewController {
    
    private var timeline = [Array<Tweet>]()
    { didSet { print(timeline.count) } }
    
    public var maxID: String?
    { didSet { print("max: \(maxID ?? "maxID NOT EXIST")") } }
    
    public var sinceID: String?
    { didSet { print("since: \(sinceID ?? "sinceID NOT EXIST")") } }
    
    public var fetchNewer = true
    /*
     if there is a newer batch, there exists a maxID;
     if there is a older batch, there exists a sinceID.
     
     if last panning gesture is upward, fetchNewer is true;
     if last panning gesture is downward, fetchNewer is false.
     */
    
    
    // MARK: - Life cycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshTimeline()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.refreshControl?.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    func insertNewTweets(with newTweets: [Tweet]) {
        self.timeline.insert(newTweets, at: 0)
        self.tableView.insertSections([0], with: .automatic)
    }
    
    private func refreshTimeline() {
        let timeline = Timeline(maxID: maxID, sinceID: sinceID, fetchNewer: fetchNewer)
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
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        refreshTimeline()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return timeline.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeline[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        let tweet = timeline[indexPath.section][indexPath.row]
        
        if let media = tweet.entities?.media {
            switch media.count {
            case 0:
                cell = tableView.dequeueReusableCell(withIdentifier: "Tweet with Text", for: indexPath)
                if let tweetCell = cell as? TweetWithTextTableViewCell {
                    tweetCell.tweet = tweet
                }
            case 1:
                cell = tableView.dequeueReusableCell(withIdentifier: "Tweet with Pic and Text", for: indexPath)
                if let tweetCell = cell as? TweetTableViewCell {
                    tweetCell.tweet = tweet
                }
            case 2:
                cell = tableView.dequeueReusableCell(withIdentifier: "Tweet with Two Pics and Text", for: indexPath)
                if let tweetCell = cell as? TweetTableViewCell {
                    tweetCell.tweet = tweet
                }
            case 3:
                cell = tableView.dequeueReusableCell(withIdentifier: "Tweet with Three Pics and Text", for: indexPath)
                if let tweetCell = cell as? TweetTableViewCell {
                    tweetCell.tweet = tweet
                }
            case 4:
                cell = tableView.dequeueReusableCell(withIdentifier: "Tweet with Four Pics and Text", for: indexPath)
                if let tweetCell = cell as? TweetTableViewCell {
                    tweetCell.tweet = tweet
                }
            default:
                cell = tableView.dequeueReusableCell(withIdentifier: "Tweet with Text", for: indexPath)
                if let tweetCell = cell as? TweetWithTextTableViewCell {
                    tweetCell.tweet = tweet
                }
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "Tweet with Text", for: indexPath)
            if let tweetCell = cell as? TweetWithTextTableViewCell {
                tweetCell.tweet = tweet
            }
        }
//        if tweet.entities?.firstPic == nil {
//            cell = tableView.dequeueReusableCell(withIdentifier: "Tweet with Text", for: indexPath)
//            if let tweetCell = cell as? TweetWithTextTableViewCell {
//                tweetCell.tweet = tweet
//            }
//        } else {
//            if tweet.text == "" {
//                cell = tableView.dequeueReusableCell(withIdentifier: "Tweet with Pic", for: indexPath)
//                if let tweetCell = cell as? TweetWithPicTableViewCell {
//                    tweetCell.tweet = tweet
//                }
//            } else {
//                cell = tableView.dequeueReusableCell(withIdentifier: "Tweet with Pic and Text", for: indexPath)
//                if let tweetCell = cell as? TweetTableViewCell {
//                    tweetCell.tweet = tweet
//                }
//            }
//        }
        return cell
    }
}
