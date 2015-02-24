//
//  ProfileViewController.swift
//  DiveLogger
//
//  Created by Rui Baltazar on 20/2/15.
//  Copyright (c) 2015 Rui Baltazar. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {
    var prefs:NSUserDefaults!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sessionManager.logoutUser()
        self.performSegueWithIdentifier("profile_to_login", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
