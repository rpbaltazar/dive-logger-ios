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
    let date: String
    let pressureIn: Int?
    let pressureOut: Int?
    let actualBottomTime: Int?
    let timeIn: NSDate?
    let timeOut: NSDate?
    
    
    init(response: NSHTTPURLResponse, representation: AnyObject) {
        location = representation.valueForKeyPath("location_name") as String
        date = representation.valueForKeyPath("dive_date") as String
        pressureIn = representation.valueForKeyPath("pressure_in") as? Int
        pressureOut = representation.valueForKeyPath("pressure_out") as? Int
        actualBottomTime = representation.valueForKeyPath("actual_bottom_time") as? Int
        timeIn = representation.valueForKeyPath("time_in") as? NSDate
        timeOut = representation.valueForKeyPath("time_out") as? NSDate
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
}

