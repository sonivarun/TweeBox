//
//  TwitterUserTableViewCell.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/15.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit
import Kingfisher
import DateToolsSwift

class TwitterUserTableViewCell: UITableViewCell {

    public var user: TwitterUser? {
        didSet {
           updateUI()
        }
    }
    
    
    // MARK - Outlets
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var createdTimeLabel: UILabel!
    
    
    private func updateUI() {
        
        profileImage.kf.setImage(with: user?.profileImageURL)
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true

        nameLabel.text = user?.name
        
        screenNameLabel.text = "@\(user?.screenName ?? "twitterUser")"
        
        tweetsCountLabel.text = "Total Tweets: \(user?.statusesCount ?? 0)"
        
        followersCountLabel.text = "Followers: \(user?.followersCount ?? 0)"
        
        createdTimeLabel.text = "Created At: \(TwitterDate(string: user?.createdAt).date?.timeAgoSinceNow ?? "")"
    }
}
