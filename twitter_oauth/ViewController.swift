//
//  ViewController.swift
//  twitter_oauth
//
//  Created by Tarang khanna on 2/8/16.
//  Copyright © 2016 Tarang khanna. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class ViewController: UIViewController {
    
    @IBAction func onLogin(sender: AnyObject) { // login button
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                // perform segue
            } else {
                // handle error
            }
        }
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

