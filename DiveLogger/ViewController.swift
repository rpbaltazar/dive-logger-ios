//
//  ViewController.swift
//  DiveLogger
//
//  Created by Rui Baltazar on 16/2/15.
//  Copyright (c) 2015 Rui Baltazar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblUsername: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //TODO: Move this to a constants manager
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            self.performSegueWithIdentifier("goto_login", sender: self)
        }
        else {
            self.lblUsername.text = prefs.valueForKey("USERNAME") as NSString
        }
    }

    @IBAction func logout(sender: UIButton) {
        self.performSegueWithIdentifier("goto_login", sender: self)
    }

}

