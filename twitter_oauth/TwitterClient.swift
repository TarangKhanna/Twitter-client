//
//  TwitterClient.swift
//  twitter_oauth
//
//  Created by Tarang khanna on 2/8/16.
//  Copyright © 2016 Tarang khanna. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterBaseUrl = NSURL(string: "https://api.twitter.com")
let twitterConsumerKey = "3chEzIG0t1ocIXOwsMIiWsmYv" // add own keys
let twitterConsumerSecret = "C9nfYX6t63gBtzX3vRJwHe4EbAve8XneQ6dWXEIuBgyATfLzV6"

class TwitterClient: BDBOAuth1SessionManager {
    class var sharedInstance: TwitterClient { // to use as singleton
        struct Static {
            static let instance = TwitterClient(
                baseURL: twitterBaseUrl,
                consumerKey: twitterConsumerKey,
                consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
}
