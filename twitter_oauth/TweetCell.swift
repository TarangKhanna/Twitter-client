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
    
    var tweet: Tweet! {
        didSet {
            self.userImage.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
            self.nameLabel.text = (tweet?.user!.name)!
            print(tweet?.user!.name)
            self.screenNameLabel.text = "@\(tweet.user!.screenname!)"
            self.messageLabel.text = tweet?.text
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
