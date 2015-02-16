//
//  LoginViewController.swift
//  DiveLogger
//
//  Created by Rui Baltazar on 16/2/15.
//  Copyright (c) 2015 Rui Baltazar. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func login(sender: UIButton) {
        let params = [
            "email": txtEmail,
            "password": txtPassword,
        ]
        
        var dataRes:NSDictionary!
        
        Alamofire.request(.POST, "http://192.168.1.19:3000/api/v1/sessions", parameters: params, encoding: .JSON)
            .responseJSON() {
                (request, response, data, error) in
                let statusCode = response?.statusCode
                
                dataRes = data as NSDictionary
                if (statusCode >= 200 && statusCode < 300){
                    //login successfully
                    //store logged in
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
