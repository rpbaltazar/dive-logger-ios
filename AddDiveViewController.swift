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
    //@IBOutlet weak var actualBottomTimeTextView: UITextField!
    @IBOutlet weak var pressureInTextView: UITextField!
    @IBOutlet weak var pressureOutTextView: UITextField!
    //@IBOutlet weak var pressureGroupTextView: UITextField!
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
        //self.actualBottomTimeTextView.delegate = self
        self.pressureInTextView.delegate = self
        self.pressureOutTextView.delegate = self
        //self.pressureGroupTextView.delegate = self
        self.commentsTextView.delegate = self
        
        self.navigationController?.navigationBar.topItem?.title = "Add Dive"
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if(textView == self.commentsTextView) {
            if(textView.text == "Comments...") {
                textView.text = ""
                textView.textColor = UIColor.blackColor()
            }
        }
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if(textView == self.commentsTextView) {
            if(textView.text == "") {
                textView.text = "Comments..."
                textView.textColor = UIColor.lightGrayColor()
            }
        }
        textView.resignFirstResponder()

    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if(textField == self.timeInTextView || textField == self.timeOutTextView) {
            
            var timeFormatExpression = "(^$)|([0-9]{1,2})|([0-9]{1,2}\\:)|([0-9]{1,2}\\:[0-9]{1,2})"
            let currentString = textField.text as NSString
            let newString:NSString = currentString.stringByReplacingCharactersInRange(range, withString: string)
            let newStringLength = newString.length
            
            switch newStringLength {
            case 0:
                return true
            case 1...2:
                timeFormatExpression = "^[0-9]{1,2}$"
            case 3:
                timeFormatExpression = "^[0-9]{1,2}\\:$"
            case 4...5:
                timeFormatExpression = "^[0-9]{1,2}\\:[0-9]{1,2}$"
            default:
                return false
            }
            
            let regex = NSRegularExpression(pattern: timeFormatExpression, options: NSRegularExpressionOptions.CaseInsensitive, error: nil)
            let numberOfMatches = regex?.numberOfMatchesInString(newString, options: nil, range: NSMakeRange(0, newString.length))
            
            if (numberOfMatches == 0){
                return false
            }
        }
        
        return true
    }
    
    @IBAction func clearForm(sender: AnyObject) {
        self.locationTextView.text = ""
        self.dateTextView.text = ""
        self.timeInTextView.text = ""
        self.timeOutTextView.text = ""
        self.pressureInTextView.text = ""
        self.pressureOutTextView.text = ""
        self.commentsTextView.text = "Comments..."
        self.commentsTextView.textColor = UIColor.lightGrayColor()
    }
    
    @IBAction func saveDive(sender: AnyObject) {
    }
}
