//
//  ApiManager.swift
//  DiveLogger
//
//  Created by Rui Baltazar on 20/2/15.
//  Copyright (c) 2015 Rui Baltazar. All rights reserved.
//


//TODO: Read more about this
import Foundation
import Alamofire

class ApiManager {
    
    class func login(params:[String:AnyObject], callback: (NSHTTPURLResponse, NSDictionary) -> Void){
        Alamofire.request(.POST, "http://underwater-me.herokuapp.com/api/v1/sessions", parameters: params, encoding: .JSON)
            .responseJSON() {
                (request, response, data, error) in
                let dataRes = data as NSDictionary
                callback(response!, dataRes)
        }
    }
    
    class func logout(params:[String:AnyObject], callback: (NSHTTPURLResponse, NSDictionary) -> Void) {
        Alamofire.request(.DELETE, "http://underwater-me.herokuapp.com/api/v1/sessions", parameters: params, encoding: .JSON)
            .responseJSON() {
                (request, response, data, error) in
                let dataRes = data as NSDictionary
                callback(response!, dataRes)
        }
    }
}
