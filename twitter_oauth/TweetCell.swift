//
//  TweetCell.swift
//  twitter_oauth
//
//  Created by Tarang khanna on 2/12/16.
//  Copyright © 2016 Tarang khanna. All rights reserved.
//

import UIKit
import SCLAlertView

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    
    
    var tweet: Tweet! {
        didSet {
            
            self.userImage.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
            self.nameLabel.text = (tweet?.user!.name)!
            self.screenNameLabel.text = "@\(tweet.user!.screenname!)"
            self.messageLabel.text = tweet?.text
            self.timeLabel.text = "\(timeAgoSinceDate((tweet?.createdAt)!, numericDates: false))"
        }
    }
    
    
    func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
        let calendar = NSCalendar.currentCalendar()
        let now = NSDate()
        let earliest = now.earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:NSDateComponents = calendar.components([NSCalendarUnit.Minute , NSCalendarUnit.Hour , NSCalendarUnit.Day , NSCalendarUnit.WeekOfYear , NSCalendarUnit.Month , NSCalendarUnit.Year , NSCalendarUnit.Second], fromDate: earliest, toDate: latest, options: NSCalendarOptions())
        
        if (components.year >= 2) {
            return "\(components.year)y"
        } else if (components.year >= 1){
            if (numericDates){
                return "1y"
            } else {
                return "1y"
            }
        } else if (components.month >= 2) {
            return "\(components.month)m"
        } else if (components.month >= 1){
            if (numericDates){
                return "1m"
            } else {
                return "1m"
            }
        } else if (components.weekOfYear >= 2) {
            return "\(components.weekOfYear)w"
        } else if (components.weekOfYear >= 1){
            if (numericDates){
                return "1w"
            } else {
                return "1w"
            }
        } else if (components.day >= 2) {
            return "\(components.day)d"
        } else if (components.day >= 1){
            if (numericDates){
                return "1d"
            } else {
                return "1d"
            }
        } else if (components.hour >= 2) {
            return "\(components.hour)h"
        } else if (components.hour >= 1){
            if (numericDates){
                return "1h"
            } else {
                return "1h"
            }
        } else if (components.minute >= 2) {
            return "\(components.minute)m"
        } else if (components.minute >= 1){
            if (numericDates){
                return "1m"
            } else {
                return "1m"
            }
        } else if (components.second >= 3) {
            return "\(components.second)s"
        } else {
            return "now"
        }
        
    }

    
    
    @IBAction func replyClicked(sender: AnyObject) {
        // post to tweet
        
    }
    
    
    @IBAction func retweetClicked(sender: AnyObject) {
        var id = tweet.tweetID
    
        TwitterClient.sharedInstance.sendRetweetWithCompletion(tweet.tweetID!) {
            (error: NSError?) in
            if error == nil {
                print("retweet suceeded")
                SCLAlertView().showInfo("Retweeted", subTitle: "Successful")
                self.tweet.retweeted = 1
                self.tweet.retweetCount! += 1
            } else {
                print("retweet failed")
            }
        }
    }
    
    @IBAction func likeClicked(sender: AnyObject) {
        var id = tweet.tweetID
        
        TwitterClient.sharedInstance.favoriteTweetWithCompletion(tweet.tweetID!) {
            (error: NSError?) in
            if error == nil {
                print("favorting tweet succeeded")
                SCLAlertView().showInfo("Liked", subTitle: "Successful")
                self.tweet.favoriteCount! += 1
                self.tweet.favorited = 1
            } else {
                print("favoriting tweet failed")
            }
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
