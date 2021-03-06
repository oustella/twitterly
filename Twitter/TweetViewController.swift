//
//  TweetViewController.swift
//  Twitter
//
//  Created by OSL on 3/12/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {
    
    var homeVC = HomeTableViewController()
    
    @IBOutlet weak var userTweetText: UITextView!
    @IBOutlet weak var tweetCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTweetText.becomeFirstResponder()
        userTweetText.delegate = self
        
        userTweetText.layer.cornerRadius = 10
        userTweetText.layer.borderWidth = 1
        userTweetText.layer.borderColor = UIColor.gray.cgColor
        tweetCount.text = String("0")
        
//        let twitterBlueColor = UIColor(red: 29, green: 161, blue: 242, alpha: 0)
//        if #available(iOS 13.0, *) {
//            let appearance = UINavigationBarAppearance()
//            appearance.configureWithOpaqueBackground()
//            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//            appearance.backgroundColor = twitterBlueColor
//            navigationItem.standardAppearance = appearance
//            navigationItem.scrollEdgeAppearance = navigationItem.standardAppearance
//
//        } else {
//            // Fallback on earlier versions
//            UINavigationBar.appearance().barTintColor = twitterBlueColor
//        }
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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let charLimit = 140
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        return newText.count <= charLimit
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let charCount = userTweetText.text.count
        tweetCount.text = String("\(charCount)")
        tweetCount.textColor = charCount > 130 ? UIColor.red : UIColor.black
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
