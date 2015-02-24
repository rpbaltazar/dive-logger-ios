//
//  DivesViewController.swift
//  DiveLogger
//
//  Created by Rui Baltazar on 20/2/15.
//  Copyright (c) 2015 Rui Baltazar. All rights reserved.
//

import UIKit
import Alamofire

class DivesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var divesListView: UITableView?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if(sessionManager.isUserLoggedIn()){
            self.divesListView?.delegate = self
            self.divesListView?.dataSource = self
            fetchDives()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if(!sessionManager.isUserLoggedIn()){
            self.performSegueWithIdentifier("dives_to_login", sender: self)
        } else {
            //TODO: check authkey validity
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
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
    
    // UITableViewDelegate methods
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        let alert = UIAlertController(title: "Item selected", message: "You selected item \(indexPath.row)", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default,
            handler: {
                (alert: UIAlertAction!) in println("An alert of type \(alert.style.hashValue) was tapped!")
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    private func fetchDives() {
        //showSpinner()
        let params = sessionManager.getAuthParams()
        //TODO: This should be done in a Api Manager
        Alamofire.request(.GET, "http://underwater-me.herokuapp.com/api/v1/dives", parameters: params)
            .responseJSON() {
                (request, response, data, error) in
                var statusCode = response?.statusCode
                if (statusCode >= 200 && statusCode < 300) {
                    let dataRes = data as NSArray
                    for diveJSON in dataRes {
                        let diveDate:NSString = diveJSON["dive_date"] as NSString
                        let diveLocation:NSString = diveJSON["location_name"] as NSString
                        diveLogBook.addDive(diveDate, location: diveLocation)
                    }
                    self.divesListView?.reloadData()
                }
                else {
                    //self.hideSpinner()
                    //login error
                    NSLog("Bode")
                }
        }
    }
}