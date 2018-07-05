//
//  UserLoginService.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 27/06/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class UserLoginService {
    
    static func userLogin(_ userLoginRequest: UserLoginRequest, completionHandler: @escaping (_ isSuccessFull: Bool, _ error: String?) -> ()) {
        
        let appSessionUrl = API.kAppSessionUrl
        let appSessionParam = ["username": API.kOpenCartApiUserName, "key": API.kOpenCartApiKey]
        
        Alamofire.request(appSessionUrl, method: .post, parameters: appSessionParam, encoding: URLEncoding.default, headers: nil)
            .responseJSON { (response) in
                
                switch response.result {
                case .success(let data):
                    
                    //Data
                    print(data)
                case .failure:
                    
                    //Failed
                    print("Failed")
                }
                
        }
    }
}
