//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by OSL on 3/5/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCellTableViewCell: UITableViewCell {
    
    var favorited: Bool = false
    var tweetId: Int = -1
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userTweet: UILabel!
    
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var tweetImage: UIImageView!
    
    // actions when tapping the heart button
    // send heart state update to Twitter API
    @IBAction func heartButtonAction(_ sender: Any) {
        if (!favorited) {
            TwitterAPICaller.client?.favoriteATweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (Error) in
                print("Cannot add favorite due to \(Error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteATweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (Error) in
                print("Cannot remove favorite due to \(Error)")
            })
        }
    }
    
    
    @IBAction func retweetAction(_ sender: Any) {
        TwitterAPICaller.client?.retweetATweet(tweetId: tweetId,
                                               success: {
            self.setRetweet(true)
        }, failure: { (error) in
            print("Could not retweet due to \(error)")
        })
        
    }
    
    // first change the favorite state
    // then change the heart image accordingly
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if (favorited){
            heartButton.setImage(UIImage(named: "favor-icon-red"),
                                 for: UIControl.State.normal)
        } else {
            heartButton.setImage(UIImage(named: "favor-icon"),
                                 for: UIControl.State.normal)
        }
    }
        
    func setRetweet(_ isRetweeted:Bool){
//        favorited = isFavorited
        if (isRetweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"),
                                 for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"),
                                 for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Prevent cell being selectable
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Source: https://medium.com/ios-seminar/why-we-use-dequeuereusablecellwithidentifier-ce7fd97cde8e
    override func prepareForReuse() {
        super.prepareForReuse()
        
        tweetImage.af_cancelImageRequest() // this should send a message to your download handler and have it cancelled.
        tweetImage.image = nil
    }

}
