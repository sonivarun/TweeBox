//
//  TweetTableViewCell.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/8.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit
import Kingfisher
//import SDWebImage

class TweetTableViewCell: UITableViewCell {

    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var tweetUserProfilePic: UIImageView!
    @IBOutlet weak var tweetCreatedTime: UILabel!
    @IBOutlet weak var tweetUserName: UILabel!
    @IBOutlet weak var tweetUserID: UILabel!
    
    func updateUI() {
        
        if let userProfileImageURL = tweet?.user.profileImageURL {
            
            // Kingfisher
//            let placeholder = UIImage(named: "placeholder")
            let processor = RoundCornerImageProcessor(cornerRadius: Constants.defaultProfileRadius)
//            self.tweetUserProfilePic?.kf.indicatorType = .activity
            self.tweetUserProfilePic?.kf.setImage(
                with: userProfileImageURL,
//                placeholder: placeholder,
                options: [.transition(.fade(Constants.picFadeInDuration)), .processor(processor)])
            
            // SDWebImage
//            self.tweetUserProfilePic?.sd_setShowActivityIndicatorView(true)
//            self.tweetUserProfilePic?.sd_setIndicatorStyle(.gray)
//            self.self.tweetUserProfilePic?.sd_setImage(with: userProfileImageURL)
        } else {
            tweetUserProfilePic?.image = nil
        }
        
        if let created = tweet?.createdTime {
            let formatter = DateFormatter()
            if Date().timeIntervalSince(created) > 24*60*60 {
                formatter.dateStyle = .short
            } else {
                formatter.timeStyle = .short
            }
            tweetCreatedTime?.text = formatter.string(from: created)
        } else {
            tweetCreatedTime?.text = nil
        }
        
        tweetUserName.text = tweet?.user.name
        if let id = tweet?.user.screenName {
            tweetUserID.text = "@" + id
        }
    }
}
