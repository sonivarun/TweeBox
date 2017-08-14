//
//  TweetTableViewCell.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/8.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit
import Kingfisher

protocol TweetTableViewCellProtocol: class {
    func profileImageTapped(section: Int, row: Int)
}

class TweetTableViewCell: UITableViewCell {
    
    // tap to segue
    weak var delegate: TweetWithPicTableViewCellProtocol?
    weak var profilrDelegate: TweetTableViewCellProtocol?
    
    var section: Int?
    var row: Int?
    var mediaIndex: Int?

    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var tweetUserProfilePic: UIImageView!
    @IBOutlet weak var tweetCreatedTime: UILabel!
    @IBOutlet weak var tweetUserName: UILabel!
    @IBOutlet weak var tweetUserID: UILabel!
    
    @IBAction func profileImageTapped(byReactingTo: UIGestureRecognizer) {
        print(section, row)
        guard let section = section, let row = row else { return }
        profilrDelegate?.profileImageTapped(section: section, row: row)
    }
    
    
    func updateUI() {
        
        if let userProfileImageURL = tweet?.user.profileImageURL, let picView = self.tweetUserProfilePic {
            
            // Kingfisher
            picView.kf.setImage(
                with: userProfileImageURL,
//                placeholder: placeholder,
                options: [
                    .transition(.fade(Constants.picFadeInDuration)),
                ]
            )
            
//            picView.layer.borderWidth = 3.0
//            picView.layer.borderColor = UIColor.lightGray.cgColor
            
            picView.layer.cornerRadius = picView.frame.size.width / 2
            picView.clipsToBounds = true
            
            // tap to segue
            let tapOnProfileImage = UITapGestureRecognizer(
                target: self,
                action: #selector(profileImageTapped(byReactingTo:))
            )
            tapOnProfileImage.numberOfTapsRequired = 1
            picView.addGestureRecognizer(tapOnProfileImage)
            picView.isUserInteractionEnabled = true            
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
