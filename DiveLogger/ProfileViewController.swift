//
//  ProfileViewController.swift
//  DiveLogger
//
//  Created by Rui Baltazar on 20/2/15.
//  Copyright (c) 2015 Rui Baltazar. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var diveCount: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.title = "Profile"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutUser(sender: AnyObject) {
        sessionManager.logoutUser()
        self.performSegueWithIdentifier("profile_to_login", sender: self)
    }
}
