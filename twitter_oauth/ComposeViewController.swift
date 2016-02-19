//
//  ComposeViewController.swift
//  twitter_oauth
//
//  Created by Tarang khanna on 2/18/16.
//  Copyright © 2016 Tarang khanna. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    @IBOutlet weak var tweetText: UITextView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var screenLabel: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = User.currentUser?.name
        self.profileImage.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func tweetClicked(sender: AnyObject) {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
