//
//  PhotoViewController.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/11.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit

class PhotoViewController: PannableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.hidesBarsOnTap = true
//        tabBarController?.tabBar.isHidden = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return navigationController?.isNavigationBarHidden == true
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true)
    }
}
