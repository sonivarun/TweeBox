//
//  VideoViewerViewController.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/13.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit
import BMPlayer

class VideoViewerViewController: PannableViewController {
    
    private var isInLandscapeMode: Bool!
    
    public var tweetMedia: TweetMedia! {
        didSet {
            let player = BMPlayer()
            player.center = view.center
            view.addSubview(player)
            player.snp.makeConstraints { (make) in
//                make.centerY.equalTo(self.view.snp.centerY)
//                make.left.right.equalTo(self.view)
                make.center.equalTo(self.view)
                make.leading.greaterThanOrEqualTo(0)
                make.trailing.greaterThanOrEqualTo(0)
                make.top.greaterThanOrEqualTo(0)
                make.bottom.greaterThanOrEqualTo(0)
                let aspectRatio = CGFloat((tweetMedia.videoInfo?.aspectRatio[1])!) / CGFloat((tweetMedia.videoInfo?.aspectRatio[0])!)
                make.height.equalTo(player.snp.width).multipliedBy(aspectRatio).priority(750)
            }
            player.backBlock = { [unowned self] (wtf) in
                let _ = self.presentingViewController?.dismiss(animated: true)
            }
            
            let asset = BMPlayerResource(url: (tweetMedia.videoInfo?.variants?[0].url)!, name: tweetMedia.extAltText ?? "")
            player.setVideo(resource: asset)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
//    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
//        return .slide
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        let size: CGSize = UIScreen.main.bounds.size
        if size.width / size.height > 1 {
            isInLandscapeMode = true
        } else {
            isInLandscapeMode = false
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if (size.width / size.height > 1) {
            isInLandscapeMode = true
        } else {
            isInLandscapeMode = false
        }
    }
}
