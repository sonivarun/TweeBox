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
    
    public var maxID: String? {
        didSet {
            print("outer max: \(maxID)")
        }
    }
    public var sinceID: String? {
        didSet {
            print("outer min: \(sinceID)")
        }
    }
    public var fetchNewer = true
    public var fetchOlder = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addLoginButton()
    }
    
    private func addLoginButton() {
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if session != nil {
                print("signed in as \(session!.userName)")
            } else if error != nil {
                print("error: \(error!.localizedDescription)")
            }
        })
        
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    }
    
    @IBAction func createClient(_ sender: UIButton) {
        print("CLICKED")
        let timeline = Timeline(maxID: maxID, sinceID: sinceID, fetchNewer: fetchNewer, fetchOlder: fetchOlder)
        timeline.fetchData { (maxID, sinceID) in
            if maxID != nil {
                self.maxID = maxID
            }
            if sinceID != nil {
                self.sinceID = sinceID
            }
        }
    }
}
