//
//  ImageViewerViewController.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/11.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit

class ImageViewerViewController: PannableViewController {
    
    fileprivate var imageView = UIImageView()
    
    public var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            
            let imageFactor = imageView.frame.size.width / imageView.frame.size.height
            
            let screenWidth = UIScreen.main.bounds.size.width
            let screenHeight = UIScreen.main.bounds.size.height
            let screenFactor = screenWidth / screenHeight
            
            if imageFactor >= screenFactor {  // image is wider
                imageView.frame.size.width = screenWidth
                imageView.frame.size.height = screenWidth / imageFactor
            } else {
                imageView.frame.size.height = screenHeight
                imageView.frame.size.width = screenHeight * imageFactor
            }
            imageView.center = view.center
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.maximumZoomScale = 5.0
            scrollView.minimumZoomScale = 0.5
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
        }
    }

    
    // MARK - Life Cycle
    
    override var prefersStatusBarHidden: Bool {
        return true
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

extension ImageViewerViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
        // center the image as it becomes smaller than the size of the screen
        let boundsSize = scrollView.bounds.size
        var frameToCenter = imageView.frame
        
        // center horizontally and vertically
        let widthDiff = boundsSize.width  - frameToCenter.size.width
        let heightDiff = boundsSize.height - frameToCenter.size.height
        frameToCenter.origin.x = (widthDiff > 0) ? widthDiff / 2 : 0
        frameToCenter.origin.y = (heightDiff > 0) ? heightDiff / 2 : 0
        
        imageView.frame = frameToCenter

    }
}
