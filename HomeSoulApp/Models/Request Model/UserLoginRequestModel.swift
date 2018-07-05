//
//  UserLoginRequestModel.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 27/06/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation

struct UserLoginRequest {
    var username = ""
    var key = ""
    
    public func toDictionary() -> Dictionary<String, Any> {
        var params = Dictionary<String, Any>()
        params["username"] = username
        params["key"] = key
        return params
    }
}
