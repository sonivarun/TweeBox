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
    
    public var tweetMedia: TweetMedia! {
        didSet {
            let player = BMPlayer()
            player.center = view.center
            view.addSubview(player)
            player.snp.makeConstraints { (make) in
                make.centerY.equalTo(self.view.snp.centerY)
                make.left.right.equalTo(self.view)
                // 注意此处，宽高比 16:9 优先级比 1000 低就行，在因为 iPhone 4S 宽高比不是 16：9
                make.height.equalTo(player.snp.width).multipliedBy(9.0 / 16.0).priority(750)
            }
            player.backBlock = { [unowned self] (wtf) in
//                let _ = self.navigationController?.popViewController(animated: true)
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
}
