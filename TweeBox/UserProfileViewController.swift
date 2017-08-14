//
//  UserProfileViewController.swift
//  TweeBox
//
//  Created by 4faramita on 2017/8/10.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit
import TwitterKit

class UserProfileViewController: UIViewController {

    public var userID: String?
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var screenNameTextLabel: UILabel!
    
    override func viewDidLoad() {
        profilePic.image = UIImage(named: "picPlaceholder")
        nameTextLabel.text = "我的阿波罗鸡盒"
        screenNameTextLabel.text = "@4faramita"
    }
}
