//
//  ImageViewerViewController.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/11.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit

class ImageViewerViewController: PannableViewController {
    
    public var image: UIImage? {
        didSet {
            let imageView = UIImageView(image: image)
            imageView.center = view.center
            view.addSubview(imageView)
        }
    }
    
    
    // MARK - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        blur()
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
    
//    private func blur() {
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.addSubview(blurEffectView)
//    }
}
