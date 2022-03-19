//
//  ProfileViewController.swift
//  Twitter
//
//  Created by OSL on 3/18/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tagLine: UILabel!
    @IBOutlet weak var stats: UILabel!
    
    var userProfile = (NSDictionary)()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myUrl = "https://api.twitter.com/1.1/account/verify_credentials.json"
        TwitterAPICaller.client?.getDictionaryRequest(url: myUrl, parameters: nil, success: {
            (userProfile: (NSDictionary)) in
            let boldAttribute = [
               NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 18.0)!
            ]
            let boldText = NSAttributedString(string: userProfile["name"] as! String, attributes: boldAttribute)
            let newString = NSMutableAttributedString()
            newString.append(boldText)
            self.userName.attributedText = newString
            self.tagLine.text = userProfile["description"] as? String

            
            let numFollowers = userProfile["followers_count"] as! Int
            let numFollowing = userProfile["following"] as! Int
            self.stats.text = String("\(numFollowers) Followers  \(numFollowing) Following")
            
            let imageUrl = URL(string: (userProfile["profile_image_url_https"] as? String)!)
            let data = try? Data(contentsOf: imageUrl!)
            if let imageData = data {
                self.profileImage.image = UIImage(data: imageData)
            }
            
        }, failure: { (Error) in
            print(Error.localizedDescription)
            print("Could not retrieve user profile.")
        })
                
//        print(self.userProfile)
//        userName.text = userProfile["name"] as? String
//        tagLine.text = userProfile["description"] as? String
//        print(userProfile)

        // Do any additional setup after loading the view.
    }
    
    func getUserProfile() {
        let myUrl = "https://api.twitter.com/1.1/account/verify_credentials.json"
        TwitterAPICaller.client?.getDictionaryRequest(url: myUrl, parameters: nil, success: {
            (userProfile: (NSDictionary)) in
            self.userProfile = userProfile
        }, failure: { (Error) in
            print(Error.localizedDescription)
            print("Could not retrieve user profile.")
        })
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
