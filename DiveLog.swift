//
//  DiveLog.swift
//  Underwater Me
//
//  Created by Rui Baltazar on 23/2/15.
//  Copyright (c) 2015 Rui Baltazar. All rights reserved.
//

import UIKit

var diveLogBook:DiveLogBook = DiveLogBook()

struct diveLog {
    var date = ""
    var location = ""
}

class DiveLogBook: NSObject {
    var diveLogs = [diveLog]()
    
    func addDive(date: NSString, location: NSString) {
        let dive:diveLog = diveLog(date:date, location:location)
        NSLog(date)
        NSLog(location)
        
        diveLogs.append(dive)
    }
    
}