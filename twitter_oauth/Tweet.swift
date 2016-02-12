//
//  Tweet.swift
//  twitter_oauth
//
//  Created by Tarang khanna on 2/9/16.
//  Copyright © 2016 Tarang khanna. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var favorited: Int?
    var retweetCount: Int?
    var retweeted: Int?
    var tweetID: String?
    var favoriteCount: Int?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        let formatter = NSDateFormatter() // expensive
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        // use lazy when you need the variable
        
        favorited = dictionary["favorited"] as? Int
        retweetCount = dictionary["retweet_count"] as? Int
        retweeted = dictionary["retweeted"] as? Int
        tweetID = dictionary["id_str"] as? String
        favoriteCount = dictionary["favorite_count"] as? Int
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
}
