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
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient { // to use as singleton
        struct Static {
            static let instance = TwitterClient(
                baseURL: twitterBaseUrl,
                consumerKey: twitterConsumerKey,
                consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        // Fetch request token & redirect 
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        TwitterClient.sharedInstance.fetchRequestTokenWithPath(
            "oauth/request_token",
            method: "GET",
            callbackURL: NSURL(string: "cpttwitterdemo://oauth"),
            scope: nil,
            success: {
                (requestToken: BDBOAuth1Credential!) -> Void in
                print("Got the request token")
                
                let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                
                UIApplication.sharedApplication().openURL(authURL!)
                
            }) {
                (error: NSError!) -> Void in
                print("Failed to get request token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath(
            "oauth/access_token",
            method: "POST",
            requestToken: BDBOAuth1Credential(queryString: url.query),
            success: { (accessToken: BDBOAuth1Credential!) -> Void in
                print("Got the access token!")
                
                TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
                
                TwitterClient.sharedInstance.GET(
                    "1.1/account/verify_credentials.json",
                    parameters: nil,
                    success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                        //                        print("user: \(response!)")
                        let user = User(dictionary: response as! NSDictionary)
                        
                        User.currentUser = user // set
                        print("user: \(user.name!)")
                        self.loginCompletion!(user: user, error:  nil)
                    },
                    failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                        print("error getting current user")
                        self.loginCompletion?(user: nil, error: error)
                })
                
                TwitterClient.sharedInstance.GET(
                    "1.1/statuses/home_timeline.json",
                    parameters: nil,
                    success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                        //                        print("home_timeline: \(response!)")
                        let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                        for tweet in tweets {
                            print("text: \(tweet.text!), created: \(tweet.createdAt!)")
                        }
                    },
                    failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                        print("error getting current user")
                        
                })
                
            },
            failure: { (error: NSError!) -> Void in
                print("Failed to receive access token")
                self.loginCompletion?(user: nil, error: error)
        })
    }
}
