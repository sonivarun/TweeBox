//
//  TweetWithPicAndTextTableViewCell.swift
//  SmashTag
//
//  Created by 4faramita on 2017/7/5.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit
import Kingfisher
//import SDWebImage

class TweetWithPicAndTextTableViewCell: TweetTableViewCell {
    
    @IBOutlet weak var tweetTextContent: UILabel!
    @IBOutlet weak var tweetPicContent: UIImageView!
    
    
    override func updateUI() {
        
        super.updateUI()
        
        tweetTextContent.text = tweet?.text
        
        if let tweetPicURL = tweet?.entities?.firstPic?.mediaURL {
            
            // Kingfisher
            self.tweetPicContent?.kf.indicatorType = .activity
            self.tweetPicContent?.kf.setImage(with: tweetPicURL, options: [.transition(.fade(0.2))])
            
            // SDWebImage
//            self.tweetPicContent?.sd_setShowActivityIndicatorView(true)
//            self.tweetPicContent?.sd_setIndicatorStyle(.gray)
//            self.tweetPicContent?.sd_setImage(with: tweetPicURL)
        } else {
            tweetPicContent?.image = nil
        }
    }
    
}
