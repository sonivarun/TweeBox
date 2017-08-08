//
//  TweetWithPicAndTextTableViewCell.swift
//  SmashTag
//
//  Created by 4faramita on 2017/7/5.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit

class TweetWithPicAndTextTableViewCell: TweetTableViewCell {
    
    @IBOutlet weak var tweetTextContent: UILabel!
    @IBOutlet weak var tweetPicContent: UIImageView!
    
    
    override func updateUI() {
        
        super.updateUI()
        
        tweetTextContent.text = tweet?.text
        
        if let tweetPicURL = tweet?.entities?.firstPic?.mediaURL {
            
            DispatchQueue.global(qos: .userInitiated).async {
                let tweetPicData = try? Data(contentsOf: tweetPicURL)
                if let imageData = tweetPicData,
                    let image = UIImage(data: imageData) {
                    DispatchQueue.main.sync { [weak self] in
                        self?.tweetPicContent?.image = image
                    }
                }
            }
        } else {
            tweetPicContent?.image = nil
        }
    }
    
}
