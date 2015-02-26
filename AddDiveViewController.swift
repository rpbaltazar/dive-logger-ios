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
    
    var datePickerView:UIDatePicker = UIDatePicker()

    

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
        self.animateTextView(textView, up: true)
        if(textView == self.commentsTextView) {
            if(textView.text == "Comments...") {
                textView.text = ""
                textView.textColor = UIColor.blackColor()
            }
        }
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        self.animateTextView(textView, up: false)
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
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        let diveDate = dateFormatter.dateFromString(dateTextView.text)!
        
        dateFormatter.dateFormat = "hh:mm"
        let timeIn = dateFormatter.dateFromString(timeInTextView.text)!
        let timeOut = dateFormatter.dateFromString(timeOutTextView.text)!
        
        let pressureIn = pressureInTextView.text.toInt()!
        let pressureOut = pressureOutTextView.text.toInt()!

        let newDive = DiveModel(location: locationTextView.text, date: diveDate, pressureIn: pressureIn, pressureOut: pressureOut, timeIn: timeIn, timeOut: timeOut)
        
        ApiManager.postNewDive(newDive,
            successCallback: {(dive) -> Void in
                if let dive = dive? {
                    diveLogBook.addDive(dive)
                    self.clearForm(sender)
                }
            },
            failureCallback: {(errorCode, errorMessage) -> Void in
                
            }
        )
    }
    
    private func animateTextView(textField: UITextView, up: Bool) {
        let movementDistance:CGFloat = 120.0
        let movementDuration:NSTimeInterval = 0.3
        
        let movement:CGFloat = (up ? -movementDistance : movementDistance)
        
        UIView.beginAnimations("anim", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        UIView.commitAnimations()
    }
    
    @IBAction func datePickerShow(dateTextView: UITextView) {
        let now = NSDate()
        self.datePickerView.maximumDate = now
        self.datePickerView.datePickerMode = .Date
        
        dateTextView.inputView = datePickerView
        datePickerView.addTarget(self, action: "handleDatePicker", forControlEvents: .ValueChanged)
        handleDatePicker()
    }

    @IBAction func timePicker(timeTextView: UITextField) {
        self.datePickerView.datePickerMode = .Time
        
        timeTextView.inputView = datePickerView
        datePickerView.addTarget(self, action: "handleTimePicker", forControlEvents: .ValueChanged)
        handleTimePicker()
    }
    
    func handleDatePicker() {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateTextView.text = dateFormatter.stringFromDate(self.datePickerView.date)
    }
    
    func handleTimePicker() {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        
        if timeInTextView.isFirstResponder() {
            timeInTextView.text = dateFormatter.stringFromDate(self.datePickerView.date)
        } else if timeOutTextView.isFirstResponder() {
            timeOutTextView.text = dateFormatter.stringFromDate(self.datePickerView.date)
        }
    }
}
