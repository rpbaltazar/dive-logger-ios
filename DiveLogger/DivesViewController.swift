//
//  DivesViewController.swift
//  DiveLogger
//
//  Created by Rui Baltazar on 20/2/15.
//  Copyright (c) 2015 Rui Baltazar. All rights reserved.
//

import UIKit
import Alamofire

class DivesViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var prefs:NSUserDefaults!
    @IBOutlet weak var divesListView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        self.divesListView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        prefs = NSUserDefaults.standardUserDefaults()
        
        if(prefs.valueForKey("DIVELOGGER_AUTHKEY") == nil) {
            self.performSegueWithIdentifier("dives_to_login", sender: self)
        } else {
            let email:NSString = prefs.valueForKey("DIVELOGGER_EMAIL") as NSString
            let authkey:NSString = prefs.valueForKey("DIVELOGGER_AUTHKEY") as NSString
            
            //showSpinner()
            let params = [
                "user_email": email,
                "user_token": authkey,
            ]
            //TODO: This should be done in a Api Manager
            Alamofire.request(.GET, "http://underwater-me.herokuapp.com/api/v1/dives", parameters: params, encoding: .JSON)
                .responseJSON() {
                    (request, response, data, error) in
                    println(data)
                    let dataRes = data as NSArray
                    var statusCode = response?.statusCode
                    if (statusCode >= 200 && statusCode < 300) {
                        for diveJSON in dataRes {
                            let diveDate:NSString = diveJSON["dive_date"] as NSString
                            let diveLocation:NSString = diveJSON["location_name"] as NSString
                            diveLogBook.addDive(diveDate, location: diveLocation)
                        }
                        
                        self.divesListView.reloadData()
                    }
                    else {
                        //self.hideSpinner()
                        //login error
                        println("failed")
                    }
                    
            }

            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diveLogBook.diveLogs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "test")
        
        let dive = diveLogBook.diveLogs[indexPath.row]
        
        cell.textLabel!.text = dive.location
        cell.detailTextLabel!.text = dive.date
        return cell
    }


}