//
//  loginViewController.swift
//  Twitter
//
//  Created by OSL on 3/5/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            self.performSegue(withIdentifier: "toHomeScreen", sender: self)
        }
    }
    
    @IBAction func toLogin(_ sender: Any) {
        let myUrl = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: myUrl, success: {
            self.performSegue(withIdentifier: "toHomeScreen", sender: self)
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
        }, failure: { (Error) in
            print("Cannot log in!")
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
