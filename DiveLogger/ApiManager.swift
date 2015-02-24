//
//  ApiManager.swift
//  DiveLogger
//
//  Created by Rui Baltazar on 20/2/15.
//  Copyright (c) 2015 Rui Baltazar. All rights reserved.
//

import Foundation
import Alamofire

/**
* Response Object Serializer Extension
*/

@objc public protocol ResponseObjectSerializable {
    init(response: NSHTTPURLResponse, representation: AnyObject)
}

extension Alamofire.Request {
    public func responseObject<T: ResponseObjectSerializable>(completionHandler: (NSURLRequest, NSHTTPURLResponse?, T?, NSError?) -> Void) -> Self {
        let serializer: Serializer = { (request, response, data) in
            let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let (JSON: AnyObject?, serializationError) = JSONSerializer(request, response, data)
            if response != nil && JSON != nil {
                return (T(response: response!, representation: JSON!), nil)
            } else {
                return (nil, serializationError)
            }
        }
        
        return response(serializer: serializer, completionHandler: { (request, response, object, error) in
            completionHandler(request, response, object as? T, error)
        })
    }
}

/**
* Response Object Collection Extension
*/

@objc public protocol ResponseCollectionSerializable {
    class func collection(#response: NSHTTPURLResponse, representation: AnyObject) -> [Self]
}

extension Alamofire.Request {
    public func responseCollection<T: ResponseCollectionSerializable>(completionHandler: (NSURLRequest, NSHTTPURLResponse?, [T]?, NSError?) -> Void) -> Self {
        let serializer: Serializer = { (request, response, data) in
            let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let (JSON: AnyObject?, serializationError) = JSONSerializer(request, response, data)
            if response != nil && JSON != nil {
                return (T.collection(response: response!, representation: JSON!), nil)
            } else {
                return (nil, serializationError)
            }
        }
        
        return response(serializer: serializer, completionHandler: { (request, response, object, error) in
            completionHandler(request, response, object as? [T], error)
        })
    }
}

public class ApiManager {
    
    /*class func login(params:[String:AnyObject], callback: (NSHTTPURLResponse, NSDictionary) -> Void){
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
    }*/
    
    class func getUserDives(successCallback: ([DiveModel]?) -> Void, failureCallback: (Int, String) -> Void) {
        let params = sessionManager.getAuthParams()
        Alamofire.request(.GET, "http://underwater-me.herokuapp.com/api/v1/dives", parameters: params)
            .responseCollection { (request, response, dives: [DiveModel]?, error) in
                var statusCode = response?.statusCode
                if (statusCode >= 200 && statusCode < 300) {
                    successCallback(dives)
                }
                else {
                    failureCallback(statusCode!, "")
                }
        }
    }
    
}
