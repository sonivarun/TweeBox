//
//  NavigationViewControllerExtension.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/12.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit

extension UIViewController {
    var content: UIViewController {
        if let navigationViewController = self as? UINavigationController {
            return navigationViewController.visibleViewController ?? self
        } else {
            return self
        }
    }
}
