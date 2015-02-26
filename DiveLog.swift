//
//  DiveLog.swift
//  Underwater Me
//
//  Created by Rui Baltazar on 23/2/15.
//  Copyright (c) 2015 Rui Baltazar. All rights reserved.
//

import Foundation

var diveLogBook:DiveLogBook = DiveLogBook()

class DiveLogBook: NSObject {
    var dives = [DiveModel]()
    var lastUpdate:NSDate
    
    override init() {
        self.lastUpdate = NSDate(timeIntervalSince1970: 0)
    }
    
    func addDive(diveModel: DiveModel) {
        dives.append(diveModel)
        lastUpdate = NSDate()
        NSLog("LAST UPDATED @ %@", NSDateFormatter.localizedStringFromDate(lastUpdate, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle))
    }
    
    func clear() {
        dives = [DiveModel]()
    }    
}