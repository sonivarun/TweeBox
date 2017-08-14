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


protocol TweetWithPicTableViewCellProtocol: class {
    func imageTapped(section: Int, row: Int, mediaIndex: Int, media: [TweetMedia])
}


class TweetWithPicTableViewCell: TweetTableViewCell {
    
    private var totalMediaNum: Int!
    
    @IBAction func imageTapped(byReactingTo: UIGestureRecognizer) {
        
        let index = byReactingTo.location(in: self.tweetPicContent)
        let xBound = self.tweetPicContent.bounds.maxX
        let yBound = self.tweetPicContent.bounds.maxY
        
        let whichMedia = (index.x <= xBound, index.y <= yBound)
        
        switch whichMedia {
        case (true, true):  // up left
            mediaIndex = 0
        case (false, true):  // up right
            mediaIndex = totalMediaNum >= 2 ? 1 : 0
        case (true, false):  // down left
            mediaIndex = totalMediaNum == 4 ? 2 : 0
        case (false, false):  // down right
            mediaIndex = totalMediaNum == 4 ? 3 : (totalMediaNum == 3 ? 2 : (totalMediaNum == 2 ? 1 : 0))
        }
        
        print(">>> image index: \(mediaIndex!)")
                
        guard let section = section, let row = row, let mediaIndex = mediaIndex else { return }
        delegate?.imageTapped(section: section, row: row, mediaIndex: mediaIndex, media: (tweet?.entities?.media)!)
    }
    
    
    @IBOutlet weak var tweetPicContent: UIImageView!
    
    @IBOutlet weak var secondPic: UIImageView!
    
    @IBOutlet weak var thirdPic: UIImageView!
    
    @IBOutlet weak var fourthPic: UIImageView!
        
    private func setPic(at position: Int, of total: Int) {
        
        totalMediaNum = total
        
        let media = tweet!.entities!.media!
        
        let images = [tweetPicContent, secondPic, thirdPic, fourthPic]  // pointer or copy?
        
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
        let cutPoint = CGPoint(x: 0.5, y: 0.5)
        // means cut from middle out
        
        let actualHeight = CGFloat(pic.sizes.small.h)
        let actualWidth = CGFloat(pic.sizes.small.w)
        
        if  actualHeight / actualWidth >= aspect {
            // too long
            picWidth = actualWidth
            picHeight = picWidth * aspect
        } else {
            // too wide
            picHeight = actualHeight
            picWidth = picHeight / aspect
        }
        
        // Kingfisher
        let placeholder = UIImage(named: "picPlaceholder")!.kf.image(withRoundRadius: Constants.picCornerRadius, fit: CGSize(width: picWidth, height: picHeight))
        
        let processor = CroppingImageProcessor(size: CGSize(width: picWidth, height: picHeight), anchor: cutPoint)
            // >> RoundCornerImageProcessor(cornerRadius: Constants.picCornerRadius)
        
        if let picView = images[position] {
//            picView.kf.indicatorType = .activity
            picView.kf.setImage(
                with: tweetPicURL,
                placeholder: placeholder,
                options: [
                    .transition(.fade(Constants.picFadeInDuration)),
                    .processor(processor)
                ]
            )
            picView.layer.borderWidth = 1
            picView.layer.borderColor = UIColor.white.cgColor
            picView.layer.cornerRadius = Constants.picCornerRadius
            picView.clipsToBounds = true
            
            
            // tap to segue
            let ptap = UITapGestureRecognizer(
                target: self,
                action: #selector(imageTapped(byReactingTo:))
            )
            ptap.numberOfTapsRequired = 1
            picView.addGestureRecognizer(ptap)
            picView.isUserInteractionEnabled = true
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
