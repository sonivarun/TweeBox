//
//  TweetWithPicTableViewCell.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/8.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit
import Kingfisher
import SKPhotoBrowser
//import SDWebImage

class TweetWithPicTableViewCell: TweetTableViewCell, SKPhotoBrowserDelegate {
    
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
        let cutPointX: CGFloat
        let cutPointY: CGFloat
        
        let actualHeight = CGFloat(pic.sizes.small.h)
        let actualWidth = CGFloat(pic.sizes.small.w)
        
        if  actualHeight / actualWidth >= aspect {
            picWidth = actualWidth
            picHeight = picWidth * aspect
            cutPointX = 0
            cutPointY = (actualHeight / 2) - (picHeight / 2)
        } else {
            picHeight = actualHeight
            picWidth = picHeight / aspect
            cutPointY = 0
            cutPointX = (actualWidth / 2) - (picWidth / 2)
        }
        
        // Kingfisher
        let placeholder = UIImage(named: "picPlaceholder")
        let processor = CroppingImageProcessor(size: CGSize(width: picWidth, height: picHeight), anchor: CGPoint(x: cutPointX, y: cutPointY)) >> RoundCornerImageProcessor(cornerRadius: Constants.picCornerRadius)
        
        if let picView = pics[position] {
//            picView.kf.indicatorType = .activity
            picView.kf.setImage(
                with: tweetPicURL,
                placeholder: placeholder,
                options: [.transition(.fade(Constants.picFadeInDuration)), .processor(processor)]
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
