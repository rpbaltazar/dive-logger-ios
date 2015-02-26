//
//  DiveModel.swift
//  Underwater Me
//
//  Created by Rui Baltazar on 24/2/15.
//  Copyright (c) 2015 Rui Baltazar. All rights reserved.
//

import Foundation

final class DiveModel: ResponseObjectSerializable, ResponseCollectionSerializable {
    
    let location: String
    let date: NSDate
    let pressureIn: Int?
    let pressureOut: Int?
    let actualBottomTime: Int?
    let timeIn: NSDate?
    let timeOut: NSDate?
    
    init(location: String, date: NSDate, pressureIn: Int, pressureOut: Int, timeIn: NSDate, timeOut: NSDate) {
        self.location = location
        self.date = date
        self.pressureIn = pressureIn
        self.pressureOut = pressureOut
        self.timeIn = timeIn
        self.timeOut = timeOut
        
        self.actualBottomTime = (Int) (ceil(timeOut.timeIntervalSinceDate(timeIn) / 60))
    }
    
    init(response: NSHTTPURLResponse, representation: AnyObject) {
        var dateFormatter = NSDateFormatter()
        location = representation.valueForKeyPath("location_name") as String

        dateFormatter.dateFormat = "YYYY-MM-dd"
        let dateString = representation.valueForKeyPath("dive_date") as String
        date = dateFormatter.dateFromString(dateString)!
        
        pressureIn = representation.valueForKeyPath("pressure_in") as? Int
        pressureOut = representation.valueForKeyPath("pressure_out") as? Int
        actualBottomTime = representation.valueForKeyPath("actual_bottom_time") as? Int
        
        dateFormatter.dateFormat = "hh:mm"
        var timeString = representation.valueForKeyPath("time_in") as? String
        if timeString != nil {
            timeIn = dateFormatter.dateFromString(timeString!)
        }
        
        timeString = representation.valueForKeyPath("time_out") as? String
        if timeString != nil {
            timeOut = dateFormatter.dateFromString(timeString!)
        }
    }
    
    class func collection(#response: NSHTTPURLResponse, representation: AnyObject) -> [DiveModel] {
        var dives:[DiveModel] = []
        for divesRep in representation as [AnyObject] {
            dives.append(DiveModel(response: response, representation: divesRep))
        }
        return dives
    }
    
    func toDic() -> Dictionary<String,AnyObject> {
        return ["location_name": self.location, "dive_date":self.date]
    }
    
    func toParams() -> [String: String] {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        
        var timeInString = ""
        var timeOutString = ""
        if self.timeIn != nil {
            timeInString = dateFormatter.stringFromDate(self.timeIn!)
        }
        
        if self.timeOut != nil {
            timeOutString = dateFormatter.stringFromDate(self.timeOut!)
        }
        
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let dateInString = dateFormatter.stringFromDate(self.date)
        
        var pressureInString = ""
        if self.pressureIn != nil {
            pressureInString = String(self.pressureIn!)
        }
        
        var pressureOutString = ""
        if self.pressureOut != nil {
            pressureOutString = String(self.pressureOut!)
        }
        
        let parameterizedDive = [
            "location_name": self.location,
            "dive_date": dateInString,
            "time_in": timeInString,
            "time_out": timeOutString,
            "pressure_in": pressureInString,
            "pressure_out": pressureOutString
        ]
        
        return parameterizedDive
    }
}

