//
//  ViewController.swift
//  TweeBox
//
//  Created by 4faramita on 2017/7/27.
//  Copyright © 2017年 4faramita. All rights reserved.
//

import UIKit
import SafariServices
import TwitterKit
import SwiftyJSON
//import PromiseKit

class ViewController: UIViewController, SFSafariViewControllerDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addLoginButton()
    }
    
    private func addLoginButton() {
        let logInButton = TWTRLogInButton(logInCompletion: { [weak self] session, error in
            if session != nil {
                print("signed in as \(session!.userName)")
                self?.performSegue(withIdentifier: "login", sender: nil)
            } else if error != nil {
                print("error: \(error!.localizedDescription)")
            }
        })
        
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "To Timeline" {
//            
//            var destinationViewController = segue.destination
//            if let navigationController = destinationViewController as? UINavigationController {
//                destinationViewController = navigationController.visibleViewController ?? destinationViewController
//            }
//            
//            if let timelineViewController = destinationViewController as? TimelineTableViewController {
//                print("Segue")
//            }
//        }
//    }
}
