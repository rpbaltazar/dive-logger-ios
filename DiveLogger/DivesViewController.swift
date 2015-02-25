//
//  DivesViewController.swift
//  DiveLogger
//
//  Created by Rui Baltazar on 20/2/15.
//  Copyright (c) 2015 Rui Baltazar. All rights reserved.
//

import UIKit
import CoreData


class DivesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var divesListView: UITableView?
    @IBOutlet weak var divesSpinner: UIActivityIndicatorView!
    
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
        }
        
        self.navigationController?.navigationBar.topItem?.title = "My Dives"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diveLogBook.dives.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "test")
        let dive = diveLogBook.dives[indexPath.row]
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
    
    //TODO: Probably I just need to do this once at least while there is only mobile app
    //When moving to database implementation this should go away
    private func fetchDives() {
        var now = NSDate()
        if(now.timeIntervalSinceDate(diveLogBook.lastUpdate) > 3600){
            showSpinner()
            ApiManager.getUserDives(
                { (dives) -> Void in
                    if let dives = dives? {
                        diveLogBook.clear()
                        for dive: DiveModel in dives {
                            diveLogBook.addDive(dive)
                        }
                        self.divesListView?.reloadData()
                        self.hideSpinner()
                    }
                },
                failureCallback: { (errorCode, errorMessage) -> Void in
                    self.hideSpinner()
                    if (errorCode == 400){
                        sessionManager.logoutUser()
                        self.performSegueWithIdentifier("dives_to_login", sender: self)
                    }
                }
            )
        }
    }
    
    private func showSpinner() {
        self.divesSpinner.startAnimating()
    }
    
    private func hideSpinner() {
        self.divesSpinner.stopAnimating()
    }
}