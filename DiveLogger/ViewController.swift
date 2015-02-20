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
    
    var authToken = ""
    var email = ""
    var prefs:NSUserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        prefs = NSUserDefaults.standardUserDefaults()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //TODO: Move this to a constants manager
        if(prefs.valueForKey("DIVELOGGER_AUTHKEY") != nil) {
            authToken = prefs.valueForKey("DIVELOGGER_AUTHKEY") as NSString
            email = prefs.valueForKey("DIVELOGGER_EMAIL") as NSString
        }
        if (authToken == "") {
            self.performSegueWithIdentifier("goto_login", sender: self)
        }
        else {
            self.lblUsername.text = email
        }
    }
    
    func logoutCallback(response: NSHTTPURLResponse, dataRes: NSDictionary) {
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        self.performSegueWithIdentifier("goto_login", sender: self)
    }


    @IBAction func logout(sender: UIButton) {
        let params = [
            "user_email": email,
            "user_token": authToken
        ]
        ApiManager.logout(params, callback: logoutCallback)
    }

}

