//
//  PageManagerViewController.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/14.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit

class PageManagerViewController: PannableViewController {
    
    var pageViewController: EmbededPageViewController!
    
    public var currentIndex: Int!
    
    public var imageViewers: [ImageViewerViewController]!

    override func viewDidLoad() {
        super.viewDidLoad()

        pageViewController = self.childViewControllers.first as! EmbededPageViewController
        pageViewController.currentIndex = currentIndex
        pageViewController.imageViewers = imageViewers
    }

}
