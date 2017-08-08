//
//  TweetWithPicTableViewCell.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/8.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit
import Kingfisher
//import SDWebImage

class TweetWithPicTableViewCell: TweetTableViewCell {
    
    @IBOutlet weak var tweetPicContent: UIImageView!
    
    @IBOutlet weak var secondPic: UIImageView!
    
    @IBOutlet weak var thirdPic: UIImageView!
    
    @IBOutlet weak var fourthPic: UIImageView!
    
    
    private func setPic(at position: Int, of total: Int) {
        
        let media = tweet!.entities!.media!
        
        let pics = [tweetPicContent, secondPic, thirdPic, fourthPic]  // pointer or copy?
        
        var aspect: CGFloat {
            if (total == 2) || (total == 3 && position == 0) {
                return Constants.thinAspect
            } else {
                return Constants.normalAspect
            }
        }
        
        let pic = media[position]
        let tweetPicURL = pic.mediaURL
        
        let picWidth: CGFloat
        let picHeight: CGFloat
        
        if CGFloat(pic.sizes.small.w / pic.sizes.small.h) <= aspect {
            picWidth = CGFloat(pic.sizes.small.w)
            picHeight = picWidth * aspect
        } else {
            picHeight = CGFloat(pic.sizes.small.h)
            picWidth = picHeight / aspect
        }
        
        // Kingfisher
        let processor = CroppingImageProcessor(size: CGSize(width: picWidth, height: picHeight), anchor: CGPoint(x: 0.0, y: 0.0)) >> RoundCornerImageProcessor(cornerRadius: Constants.picCornerRadius)
        
        if let picView = pics[position] {
            picView.kf.indicatorType = .activity
            picView.kf.setImage(
                with: tweetPicURL,
                options: [.transition(.fade(0.2)), .processor(processor)]
            )
        }
    }
    
    override func updateUI() {
        
        super.updateUI()
        
        if let total = tweet?.entities?.media?.count {
            for i in 0..<total {
                setPic(at: i, of: total)
            }
        }
    }
}
