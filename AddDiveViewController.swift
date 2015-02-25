//
//  AddDiveViewController.swift
//  Underwater Me
//
//  Created by Rui Baltazar on 25/2/15.
//  Copyright (c) 2015 Rui Baltazar. All rights reserved.
//

import UIKit

class AddDiveViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var locationTextView: UITextField!
    @IBOutlet weak var dateTextView: UITextField!
    @IBOutlet weak var timeInTextView: UITextField!
    @IBOutlet weak var timeOutTextView: UITextField!
    @IBOutlet weak var actualBottomTimeTextView: UITextField!
    @IBOutlet weak var pressureInTextView: UITextField!
    @IBOutlet weak var pressureOutTextView: UITextField!
    @IBOutlet weak var pressureGroupTextView: UITextField!
    @IBOutlet weak var commentsTextView: UITextView!
    
    @IBOutlet weak var clearFormButton: UIButton!
    @IBOutlet weak var saveDiveButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.locationTextView.delegate = self
        self.dateTextView.delegate = self
        self.timeInTextView.delegate = self
        self.timeOutTextView.delegate = self
        self.actualBottomTimeTextView.delegate = self
        self.pressureInTextView.delegate = self
        self.pressureOutTextView.delegate = self
        self.pressureGroupTextView.delegate = self
        self.commentsTextView.delegate = self
        
        self.navigationController?.navigationBar.topItem?.title = "Add Dive"
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func clearForm(sender: AnyObject) {
    }
    
    
    @IBAction func saveDive(sender: AnyObject) {
    }
}
