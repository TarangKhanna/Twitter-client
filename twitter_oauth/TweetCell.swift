//
//  TweetCell.swift
//  twitter_oauth
//
//  Created by Tarang khanna on 2/12/16.
//  Copyright © 2016 Tarang khanna. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    var tweet: Tweet! {
        didSet {
            
            self.userImage.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
            self.nameLabel.text = (tweet?.user!.name)!
            self.screenNameLabel.text = "@\(tweet.user!.screenname!)"
            self.messageLabel.text = tweet?.text
            self.timeLabel.text = "\(timeAgoSinceDate((tweet?.createdAt)!, numericDates: false))"
//            nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
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
                return "Last year"
            }
        } else if (components.month >= 2) {
            return "\(components.month)m"
        } else if (components.month >= 1){
            if (numericDates){
                return "1m"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear >= 2) {
            return "\(components.weekOfYear)w"
        } else if (components.weekOfYear >= 1){
            if (numericDates){
                return "1w"
            } else {
                return "Last week"
            }
        } else if (components.day >= 2) {
            return "\(components.day)d"
        } else if (components.day >= 1){
            if (numericDates){
                return "1d"
            } else {
                return "Yesterday"
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
                return "A minute ago"
            }
        } else if (components.second >= 3) {
            return "\(components.second)s"
        } else {
            return "now"
        }
        
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
