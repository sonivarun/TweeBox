//
//  TweetWithPicAndTextTableViewCell.swift
//  SmashTag
//
//  Created by 4faramita on 2017/7/5.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit


class TweetWithPicAndTextTableViewCell: TweetWithPicTableViewCell {
    
    @IBOutlet weak var tweetTextContent: UILabel!
    
    public var pureMedia = false
    
    override func updateUI() {
        
        super.updateUI()
        
        if pureMedia {
            tweetTextContent?.removeFromSuperview()
        } else {
            tweetTextContent?.text = tweet?.text
        }
    }
    
}
