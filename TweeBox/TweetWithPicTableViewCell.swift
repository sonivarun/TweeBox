//
//  TweetWithPicTableViewCell.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/8.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit

class TweetWithPicTableViewCell: TweetTableViewCell {
    
    @IBOutlet weak var tweetPicContent: UIImageView!
    
    
    override func updateUI() {
        
        super.updateUI()
                
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
