//
//  EmbededPageViewController.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/13.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit

class EmbededPageViewController: UIPageViewController {
    
    public var currentIndex: Int!
    
    public var imageViewers: [ImageViewerViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
    }
    
    func viewImageViewerViewController(_ index: Int) -> ImageViewerViewController? {
        guard storyboard != nil
        else {
            return nil
        }
        
        return imageViewers[index]
    }
}


extension EmbededPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? ImageViewerViewController,
            let index = viewController.photoIndex,
            index > 0 {
            return viewImageViewerViewController(index - 1)
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? ImageViewerViewController,
            let index = viewController.photoIndex,
            (index + 1) < imageViewers.count {
            return viewImageViewerViewController(index + 1)
        }
        
        return nil
    }
}
