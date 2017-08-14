//
//  UserTimelineTableViewController.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/10.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit
import TwitterKit
import Kingfisher
import MXParallaxHeader
import DynamicBlurView

class UserTimelineTableViewController: TimelineTableViewController {
    
    public var user: TwitterUser? {
        didSet {
            userID = user?.id
        }
    }

    var userID: String? {
        didSet {
            refreshTimeline()
        }
    }
    
//    private var isRefreshing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addHeader()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        
//        if let height = tableView.parallaxHeader.view?.bounds.height, height > CGFloat(300), !isRefreshing {
//            print("refreshing")
//            isRefreshing = true
//            refreshTimeline()
//        }
//    }
    
    override func hideBarsOnScrolling() { }
    override func stopHiddingbard() { }
        
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
            if let tweets = tweets, tweets.count != 0 {
                self?.insertNewTweets(with: tweets)
//                self?.tableView.reloadData()
            }
            
//            Timer.scheduledTimer(
//                withTimeInterval: TimeInterval(0.1),
//                repeats: false) { (timer) in
//                    self?.refreshControl?.endRefreshing()
//            }
        }
//        isRefreshing = false
    }
    
    override func profileImageTapped(section: Int, row: Int) {
        
        print("profile tapped")
        
        let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserProfileViewController")
        
        let segue = UIStoryboardSegue(identifier: "profileImageTapped", source: self, destination: destinationViewController) {
            self.navigationController?.show(destinationViewController, sender: self)
        }
        
        self.clickedTweet = timeline[section][row]
        
        self.prepare(for: segue, sender: self)
        segue.perform()
    }
    
    override func showEmptyWarningMessage() {
        emptyWarningCollapsed = true
    }

    
    // Header
    private func addHeader() {
        let headerView = UIImageView()
        headerView.kf.setImage(with: user?.profileBackgroundImageURL)
        
        // blur???
        let blurView = DynamicBlurView(frame: headerView.bounds)
        blurView.blurRadius = 100
        blurView.dynamicMode = .tracking
        view.addSubview(blurView)
        
        let profileImageView = UIImageView()
        headerView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerView)
            make.left.equalTo(headerView).offset(20)
            make.width.equalTo(Constants.profileImageRadius * 2)
            make.height.equalTo(Constants.profileImageRadius * 2)
        }
        profileImageView.kf.setImage(with: user?.profileImageURL)
        
        profileImageView.layer.borderWidth = 3.0
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.cornerRadius = Constants.profileImageRadius
        profileImageView.clipsToBounds = true
        
        
        let nameLabel = UILabel()
        headerView.addSubview(nameLabel)
        nameLabel.text = user?.name
        nameLabel.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .headline), size: 22)
        nameLabel.numberOfLines = 1
        nameLabel.lineBreakMode = .byTruncatingTail
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerView).offset(20 + (Constants.profileImageRadius * 2) + 10)
            make.top.equalTo(headerView).offset(20)
        }
        
        let screenNameLabel = UILabel()
        headerView.addSubview(screenNameLabel)
        screenNameLabel.text = "@\(user?.screenName ?? "twitterUser")"
        screenNameLabel.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .caption1), size: 15)
        screenNameLabel.textColor = .gray
        screenNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerView).offset(20 + (Constants.profileImageRadius * 2) + 8)
            make.top.equalTo(headerView).offset(20 + 25 + 6)
        }
        
        let bioLabel = UILabel()
        headerView.addSubview(bioLabel)
        bioLabel.text = user?.description
        bioLabel.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 16)
        bioLabel.lineBreakMode = .byWordWrapping
        bioLabel.numberOfLines = 0
        bioLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerView).offset(20 + (Constants.profileImageRadius * 2) + 10)
            make.right.equalTo(headerView).offset(-20)
            make.top.equalTo(headerView).offset(20 + 25 + 10 + 15 + 8)
        }
        
        
        headerView.contentMode = .scaleAspectFill
        
        tableView.parallaxHeader.view = headerView
        tableView.parallaxHeader.height = 200
        tableView.parallaxHeader.mode = .fill
        tableView.parallaxHeader.minimumHeight = 0
    }
}
