//
//  TweetsViewController.swift
//  twitter_oauth
//
//  Created by Tarang khanna on 2/12/16.
//  Copyright © 2016 Tarang khanna. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh
import DGActivityIndicatorView
import ElasticTransition

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        retrieve()
        
        // Pull to refresh
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor.whiteColor()
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            self!.retrieve()
            self?.tableView.dg_stopLoading()
            }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(UIColor(red: 51/255, green: 139/255, blue: 182/255, alpha: 1))
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
        
    }
    
    func retrieve() {
        TwitterClient.sharedInstance.homeTimelineWithCompletion(nil, completion: {(tweets,
            error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            // reload tableview
            // understand post logic
        })
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil{
            return (tweets?.count)!
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = tweets![indexPath.row]
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        tableView.dg_removePullToRefresh()
    }
}

extension UIScrollView {
    // to fix a problem where all the constraints of the tableview
    // are deleted
    func dg_stopScrollingAnimation() {}
}
