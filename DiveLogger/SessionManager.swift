//
//  SessionManager.swift
//  Underwater Me
//
//  Created by Rui Baltazar on 24/2/15.
//  Copyright (c) 2015 Rui Baltazar. All rights reserved.
//

import UIKit

var sessionManager:SessionManager = SessionManager()
class SessionManager {

    let prefs:NSUserDefaults!
    let AUTHKEY = "DIVELOGGER_AUTHKEY"
    let EMAIL = "DIVELOGGER_EMAIL"
    
    init(){
        prefs = NSUserDefaults.standardUserDefaults()
    }
    
    func isUserLoggedIn() -> Bool {
        return prefs.valueForKey(AUTHKEY) != nil
    }
    
    func loginUser(authtoken:NSString, email:NSString) {
        prefs.setObject(authtoken, forKey: AUTHKEY)
        prefs.setObject(email, forKey: EMAIL)
        prefs.synchronize()

    }
    
    func logoutUser() {
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
    }
    
    func getAuthParams() -> [String: String] {
        var params = [
            "user_email": getEmail(),
            "user_token": getAuthtoken()
        ]
        
        return params
    }
    
    func getEmail() -> String {
        return prefs.valueForKey(EMAIL) as String
    }
    
    func getAuthtoken() -> String {
        return prefs.valueForKey(AUTHKEY) as String
    }
}
