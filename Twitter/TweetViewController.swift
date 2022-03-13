//
//  TweetViewController.swift
//  Twitter
//
//  Created by OSL on 3/12/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    var homeVC = HomeTableViewController()
    
    @IBOutlet weak var userTweetText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTweetText.becomeFirstResponder()
    }
    
    @IBAction func cancelTweet(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func tweet(_ sender: Any) {
        // if user tweet is not empty
        if (!userTweetText.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: userTweetText.text,
                                               success: {
                self.dismiss(animated: true, completion: self.homeVC.viewDidLoad)
                
            }, failure: { (Error) in
                print("Can not tweet due to \(Error)")
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
