//
//  LoginViewController.swift
//  DiveLogger
//
//  Created by Rui Baltazar on 16/2/15.
//  Copyright (c) 2015 Rui Baltazar. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        txtEmail.delegate = self
        txtPassword.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: UIButton) {
        let params = [
            "email": txtEmail.text,
            "password": txtPassword.text,
        ]
        //TODO: This should be done in a Api Manager
        Alamofire.request(.POST, "http://underwater-me.herokuapp.com/api/v1/sessions", parameters: params, encoding: .JSON)
            .responseJSON() {
                (request, response, data, error) in
                let dataRes = data as NSDictionary
                var statusCode = response?.statusCode
                if (statusCode >= 200 && statusCode < 300) {
                    let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    prefs.setObject(dataRes["authentication_token"], forKey: "DIVELOGGER_AUTHKEY")
                    prefs.setObject(dataRes["email"], forKey: "DIVELOGGER_EMAIL")
                    prefs.synchronize()
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                else {
                    //login error
                    var alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign in Failed!"
                    alertView.message = "Incorrect email or password"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
