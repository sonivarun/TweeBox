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
    
    override func updateUI() {
        
        super.updateUI()
        
        tweetTextContent.text = tweet?.text
    }
    
}
