//
//  TweetsViewController.swift
//  twitter_oauth
//
//  Created by Tarang khanna on 2/12/16.
//  Copyright © 2016 Tarang khanna. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        TwitterClient.sharedInstance.homeTimelineWithCompletion(nil, completion: {(tweets,
            error) -> () in
            self.tweets = tweets
            // reload tableview
            // understand post logic
        })
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
