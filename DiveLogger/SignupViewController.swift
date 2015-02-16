//
//  SignupViewController.swift
//  DiveLogger
//
//  Created by Rui Baltazar on 16/2/15.
//  Copyright (c) 2015 Rui Baltazar. All rights reserved.
//

import UIKit
//TODO: Move Alamofire to a restServiceHandler
import Alamofire

class SignupViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblErrorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func register(sender: UIButton) {
        var email:NSString = txtEmail.text as NSString
        var password:NSString = txtPassword.text as NSString
        
        if (email.isEqualToString("") || password.isEqualToString("") ){
            lblErrorMessage.text = "Please fill in both fields"
            lblErrorMessage.textColor = UIColor.redColor()
        }
        else {
            let params = [
                "email": email,
                "password": password,
                "password_confirmation": password
            ]
            var dataRes:NSDictionary!
            
            Alamofire.request(.POST, "http://192.168.1.19:3000/api/v1/registrations", parameters: params, encoding: .JSON)
                .responseJSON() {
                (request, response, data, error) in
                    let statusCode = response?.statusCode
                    
                    dataRes = data as NSDictionary
                    if (statusCode >= 200 && statusCode < 300){
                        //registered successfully
                        NSLog("ALL ok: %d", dataRes["id"] as Int)
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    else {
                        var errorsList:NSDictionary = dataRes["error"] as NSDictionary
                        var emailErrors:NSArray = errorsList["email"] as NSArray
                        var passwordErrors:NSArray = errorsList["password"] as NSArray
                        println(emailErrors)
                        println(passwordErrors)
                    }
                }
        }
    }

    @IBAction func gotoLogin(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
