//
//  PhotoViewController.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/11.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true)
    }
}
